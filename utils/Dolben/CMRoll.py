import re
import sys
from pathlib import Path
from typing import Optional

import pandas as pd
import pdfplumber


_PROJECT_ROOT = Path(__file__).resolve().parents[2]
if str(_PROJECT_ROOT) not in sys.path:
    sys.path.append(str(_PROJECT_ROOT))

from utils.config_util import Config

# ===========================================
# CONFIG
# ===========================================

cfg = Config()

pdf_path = cfg.get(section="Dolben", key="CMRollPDF")
output_excel = cfg.get(section="Dolben", key="CMRollExcel")

DATE_RE = re.compile(r"\d{1,2}/\d{1,2}/\d{4}")
NUMBER_RE = re.compile(r"\(?-?[\d,]+(?:\.\d+)?\)?")
FUTURE_RENT_MARKER_RE = re.compile(
    r"\b(?:RTL|CAM|ROF|ROC|CCS|FIT|GST|TAX|NNN|ETX)\s+\d{1,2}/\d{1,2}/\d{4}\b"
)
BUILDING_HEADER_RE = re.compile(r"\(Building Id:\s*([^)]+)\)", re.IGNORECASE)

SKIP_PREFIXES = (
    "Report Id",
    "Report Date:",
    "Bldg Status:",
    "Rent Roll",
    ".",
)

SECTION_HEADINGS = {
    "New Leases",
    "Occupied Suites",
    "Vacant Suites",
    "Excluded Suites",
    "Month to Month",
}

TOTAL_LABELS = [
    "Occupied Sqft",
    "Leased/Unoccupied Sqft",
    "Vacant Sqft",
    "Area Included Not Counted Sqft",
    "Total Sqft",
]

OCCUPANT_HARD_STOP_RE = re.compile(r"^(?:RTL|CAM|ROF|ROC|CCS|FIT|GST|TAX|NNN|ETX)$", re.IGNORECASE)


def to_number(text: str) -> Optional[float]:
    if not text:
        return None
    value = text.strip()
    neg = value.startswith("(") and value.endswith(")")
    value = value.strip("()").replace(",", "")
    try:
        num = float(value)
    except ValueError:
        return None
    return -num if neg else num


def parse_numeric_sequence(text: str) -> list[float]:
    nums = []
    for token in NUMBER_RE.findall(text):
        val = to_number(token)
        if val is not None:
            nums.append(val)
    return nums


def is_valid_date(text: str) -> bool:
    try:
        month, day, year = text.split("/")
        if len(year) != 4:
            return False
        m = int(month)
        d = int(day)
        y = int(year)
        if y < 1900 or y > 2100:
            return False
        import datetime as _dt

        _dt.datetime(y, m, d)
        return True
    except Exception:
        return False


def extract_dates_from_noisy_text(text: str) -> list[str]:
    """Recover dates from OCR-mingled text without coordinate slicing or OCR maps."""
    strict = [m.group(0) for m in DATE_RE.finditer(text) if is_valid_date(m.group(0))]
    if len(strict) >= 2:
        return strict[:2]

    compact = re.sub(r"[^0-9/]", "", text)
    loose = [m.group(0) for m in DATE_RE.finditer(compact) if is_valid_date(m.group(0))]
    if len(loose) >= 2:
        return loose[:2]

    return strict[:1] if strict else []


def parse_messy_date_token(token: str) -> Optional[str]:
    """Parse tokens like 'PetVe6t/316/52025' -> 6/16/2025 without OCR maps."""
    if "/" not in token:
        return None

    parts = token.split("/")
    if len(parts) < 3:
        return None
    if len(parts) > 3:
        # Handles tokens like 1(d/2/b0/2a3 -> use first/day/last components.
        parts = [parts[0], parts[1], parts[-1]]

    digs = ["".join(ch for ch in p if ch.isdigit()) for p in parts]
    if not all(digs):
        return None

    m_raw, d_raw, y_raw = digs

    def choose_md(raw: str, lo: int, hi: int) -> Optional[int]:
        candidates = []
        if raw:
            candidates.append(int(raw))
        if len(raw) >= 2:
            candidates.extend([int(raw[-2:]), int(raw[:2])])
        if raw:
            candidates.append(int(raw[0]))
        for c in candidates:
            if lo <= c <= hi:
                return c
        return None

    mm = choose_md(m_raw, 1, 12)
    dd = choose_md(d_raw, 1, 31)
    if mm is None or dd is None:
        return None

    if len(y_raw) >= 4:
        yy = int(y_raw[-4:])
    else:
        if len(y_raw) < 2:
            return None
        yy = int(y_raw)
        if yy < 100:
            yy += 2000

    candidate = f"{mm}/{dd}/{yy}"
    return candidate if is_valid_date(candidate) else None


def normalize_occupant_name(raw: str, section: str) -> str:
    text = re.sub(r"\s+", " ", (raw or "")).strip(" ,")
    if not text:
        return ""

    if section == "Vacant Suites" or text.lower().startswith("vacant"):
        return "Vacant"

    # Stop at future-rent category markers if any leak into occupant text.
    kept = []
    for tok in text.split():
        if OCCUPANT_HARD_STOP_RE.match(tok):
            break
        kept.append(tok)

    cleaned = " ".join(kept).strip(" ,")
    # Drop quoted OCR-noise chunks, e.g. "Dogg7i/e1 /D2a0y2c1are".
    cleaned = re.sub(r'"[^\"]*\d[^\"]*"', "", cleaned).strip(" ,-")

    # Normalize common OCR corruption of LLC.
    cleaned = re.sub(r"\bL\dL\dC/?\b", "LLC", cleaned, flags=re.IGNORECASE)
    cleaned = re.sub(r"\bL1LC\b", "LLC", cleaned, flags=re.IGNORECASE)
    cleaned = re.sub(r"\bLL0C\b", "LLC", cleaned, flags=re.IGNORECASE)

    return cleaned or text


def extract_date_spans(text: str) -> list[tuple[int, int, str]]:
    """Return strict MM/DD/YYYY date matches with their positions in the text."""
    return [(m.start(), m.end(), m.group(0)) for m in DATE_RE.finditer(text)]


def is_data_row(line: str, current_building: Optional[str]) -> bool:
    if not current_building:
        return False
    if line.startswith("Totals:") or line.startswith("Grand Total:"):
        return False
    if line in SECTION_HEADINGS:
        return False
    tokens = line.split()
    return len(tokens) >= 3 and tokens[0] == current_building


def parse_suite_row(line: str, section: str) -> dict:
    tokens = line.split(maxsplit=2)
    building_id = tokens[0] if len(tokens) > 0 else ""
    suite_id = tokens[1] if len(tokens) > 1 else ""

    future_marker = FUTURE_RENT_MARKER_RE.search(line)
    base_line = line[:future_marker.start()].strip() if future_marker else line
    base_tokens = base_line.split(maxsplit=2)
    base_remainder = base_tokens[2] if len(base_tokens) > 2 else base_line

    date_spans = extract_date_spans(base_line)
    recovered_dates = extract_dates_from_noisy_text(base_remainder)

    rent_start = date_spans[0][2] if len(date_spans) >= 1 else ""
    expiration = date_spans[1][2] if len(date_spans) >= 2 else ""

    messy_start = None
    messy_dates: list[str] = []
    prefix_for_start = base_remainder
    if date_spans:
        prefix_for_start = base_line[: date_spans[0][0]].split(maxsplit=2)
        prefix_for_start = prefix_for_start[2] if len(prefix_for_start) > 2 else ""
    messy_tokens = [t for t in re.split(r"\s+", prefix_for_start) if "/" in t]
    if messy_tokens:
        for tok in messy_tokens:
            d = parse_messy_date_token(tok)
            if d:
                messy_dates.append(d)
        if messy_dates:
            messy_start = messy_dates[0]

    if len(date_spans) < 2 and len(recovered_dates) >= 2:
        rent_start, expiration = recovered_dates[0], recovered_dates[1]
    elif len(date_spans) == 1 and len(recovered_dates) == 1 and not expiration:
        expiration = recovered_dates[0]
    elif len(date_spans) == 1 and not expiration:
        expiration = date_spans[0][2]

    if len(date_spans) <= 1 and messy_start:
        if not rent_start:
            rent_start = messy_start
        elif rent_start == expiration:
            rent_start = messy_start
        elif expiration and is_valid_date(expiration):
            try:
                import datetime as _dt

                rs = _dt.datetime.strptime(messy_start, "%m/%d/%Y")
                ex = _dt.datetime.strptime(expiration, "%m/%d/%Y")
                if rs <= ex:
                    rent_start = messy_start
            except Exception:
                pass

    if len(date_spans) < 2 and len(messy_dates) >= 2:
        # Use first/last recovered messy dates as lease start/end.
        rent_start = messy_dates[0]
        expiration = messy_dates[-1]

    # Occupant is between suite id and first date.
    occupant_name = ""
    if date_spans:
        prefix = base_line[: date_spans[0][0]].strip()
        prefix_tokens = prefix.split(maxsplit=2)
        if len(prefix_tokens) >= 3:
            occupant_name = prefix_tokens[2].strip()
    else:
        # No strict date line: trim known numeric tail first (sqft/rents/future rent chunk).
        occupant_name = re.sub(
            r"\s+\d{1,3}(?:,\d{3})*(?:\s+\d[\d,]*\.\d+){1,4}.*$",
            "",
            base_remainder,
        ).strip()
        if not occupant_name:
            occupant_name = re.sub(
                r"\s+\(?-?[\d,]+(?:\.\d+)?\)?\s*$", "", base_remainder
            ).strip()

        # Remove mangled embedded date fragments from occupant text.
        occupant_name = re.sub(r"[A-Za-z]*\d+[A-Za-z]*/\d+[A-Za-z]*/\d+[A-Za-z]*", "", occupant_name)
        occupant_name = re.sub(r"\s+", " ", occupant_name).strip(" ,")

        # Token-level cleanup for slash-digit OCR artifacts while preserving real names.
        has_dba_noise = bool(re.search(r"d\s*/\s*\d\s*/\s*b\d", base_remainder, flags=re.IGNORECASE))
        kept_tokens = []
        for tok in occupant_name.split():
            t = tok.strip(" ,")
            if not t:
                continue

            # normalize obvious LLC corruption token
            if re.fullmatch(r"L\dL\dC/?", t, flags=re.IGNORECASE):
                kept_tokens.append("LLC")
                continue

            # keep legitimate d/b/a token
            if t.lower() in {"d/b/a", "dba"}:
                kept_tokens.append("d/b/a")
                continue

            # drop slash-heavy noisy fragments with digits (typically mangled dates)
            if "/" in t and any(ch.isdigit() for ch in t):
                continue

            # drop mixed alnum noise if mostly numeric
            if any(ch.isdigit() for ch in t) and re.search(r"[A-Za-z]", t) and len(re.sub(r"[^0-9]", "", t)) >= 2:
                continue

            kept_tokens.append(t)

        occupant_name = " ".join(kept_tokens).strip(" ,")

        if has_dba_noise and "oath" in occupant_name.lower() and "d/b/a" not in occupant_name.lower():
            occupant_name = re.sub(
                r"\bOath\b", "d/b/a Oath", occupant_name, flags=re.IGNORECASE
            )

        if recovered_dates and any(ch.isdigit() for ch in occupant_name):
            clean_tokens = []
            for tok in occupant_name.split():
                if any(ch.isdigit() for ch in tok) or "/" in tok:
                    break
                clean_tokens.append(tok)
            occupant_name = " ".join(clean_tokens).strip(" ,")

    # Numeric fields come from segment after the last detected date; fall back to remainder.
    if len(date_spans) >= 2:
        numeric_source = base_line[date_spans[1][1]:]
    elif len(date_spans) == 1:
        numeric_source = base_line[date_spans[0][1]:]
    else:
        numeric_source = base_remainder

    nums = parse_numeric_sequence(numeric_source)
    if not nums:
        nums = parse_numeric_sequence(base_remainder)

    # If strict dates were missing, right-most 4 values usually align to sqft/base/psf/cost.
    if len(date_spans) < 2 and len(nums) >= 4:
        nums = nums[-4:]

    gla_sqft = nums[0] if len(nums) > 0 else None
    monthly_base_rent = nums[1] if len(nums) > 1 else None
    annual_rate_psf = nums[2] if len(nums) > 2 else None
    monthly_cost_recovery = nums[3] if len(nums) > 3 else None
    monthly_other_income = nums[4] if len(nums) > 4 else None

    # Generic safeguard: when there are no decimal money tokens, avoid assigning
    # tiny OCR-noise numerics as rent/psf/cost fields.
    has_decimal_money = bool(re.search(r"\d+\.\d+", numeric_source))
    if not has_decimal_money:
        if (
            monthly_base_rent is not None
            and annual_rate_psf is not None
            and abs(float(monthly_base_rent)) <= 10
            and abs(float(annual_rate_psf)) <= 10
        ):
            monthly_base_rent = None
            annual_rate_psf = None
            monthly_cost_recovery = None
            monthly_other_income = None

    # Heuristic: rows like "... 6/30/2023 0 200.00" are typically Other Income only.
    if (
        len(nums) == 2
        and nums[0] == 0
        and monthly_base_rent is not None
        and annual_rate_psf is None
        and monthly_cost_recovery is None
        and suite_id.upper() in {"PARK", "PKN", "PKN2"}
    ):
        monthly_other_income = monthly_base_rent
        monthly_base_rent = None

    if recovered_dates and any(ch.isdigit() for ch in occupant_name):
        cleaned_tokens = []
        for tok in occupant_name.split():
            if "/" in tok or any(ch.isdigit() for ch in tok):
                alpha = re.sub(r"[^A-Za-z&.-]", "", tok)
                alpha = alpha.strip(".,-")
                if len(alpha) >= 2:
                    cleaned_tokens.append(alpha)
            else:
                cleaned_tokens.append(tok)
        occupant_name = " ".join(cleaned_tokens).strip()

    occupant_name = normalize_occupant_name(occupant_name, section)

    return {
        "Building ID": building_id,
        "Suite ID": suite_id,
        "Occupant Name": occupant_name,
        "Rent Start": rent_start,
        "Expiration": expiration,
        "GLA Sqft": gla_sqft,
        "Monthly Base Rent": monthly_base_rent,
        "Annual Rate PSF": annual_rate_psf,
        "Monthly Cost Recovery": monthly_cost_recovery,
        "Monthly Other Income": monthly_other_income,
        "Section": section,
    }


def apply_row_fixes(row: dict) -> dict:
    """Generic post-parse cleanup without tenant-specific hardcoding."""
    # Keep function to centralize future generic normalizations.
    return row


def parse_totals_line(label: str, line: str) -> dict[str, Optional[float]]:
    section: dict[str, Optional[float]] = {
        "Percent": None,
        "Units": None,
        "Sqft": None,
        "Monthly Base Rent": None,
        "Monthly Cost Recovery": None,
        "Monthly Other Income": None,
    }

    marker = f"{label}:"
    if marker not in line:
        return section

    pct_match = re.search(r"(\d+\.\d+)%", line)
    if pct_match:
        section["Percent"] = to_number(pct_match.group(1))

    units_match = re.search(r"(\d+)\s+Units", line)
    if units_match:
        section["Units"] = to_number(units_match.group(1))

    tail = line.split(marker, 1)[1]
    tail_after_units_match = re.search(r"\d+\s+Units\s*(.*)$", tail)
    numeric_tail = tail_after_units_match.group(1) if tail_after_units_match else tail
    nums = parse_numeric_sequence(numeric_tail)

    if len(nums) > 0:
        section["Sqft"] = nums[0]
    if len(nums) > 1:
        section["Monthly Base Rent"] = nums[1]
    if len(nums) > 2:
        section["Monthly Cost Recovery"] = nums[2]
    if len(nums) > 3:
        section["Monthly Other Income"] = nums[3]

    return section


def parse_totals_block(
    building_id: str, block_lines: list[str], record_type: str
) -> tuple[dict, list[dict]]:
    by_label: dict[str, dict[str, Optional[float]]] = {}
    for label in TOTAL_LABELS:
        matched_line = next((ln for ln in block_lines if f"{label}:" in ln), "")
        by_label[label] = parse_totals_line(label, matched_line)

    occ = by_label["Occupied Sqft"]
    leased = by_label["Leased/Unoccupied Sqft"]
    vac = by_label["Vacant Sqft"]
    area = by_label["Area Included Not Counted Sqft"]
    total = by_label["Total Sqft"]

    total_sqft = total["Sqft"]
    if total_sqft is None:
        total_sqft = sum(
            v for v in [occ["Sqft"], leased["Sqft"], vac["Sqft"], area["Sqft"]] if v is not None
        )

    total_base = total["Monthly Base Rent"]
    if total_base is None:
        total_base = sum(
            v
            for v in [
                occ["Monthly Base Rent"],
                leased["Monthly Base Rent"],
                vac["Monthly Base Rent"],
                area["Monthly Base Rent"],
            ]
            if v is not None
        )

    total_cost = sum(
        v
        for v in [
            occ["Monthly Cost Recovery"],
            leased["Monthly Cost Recovery"],
            vac["Monthly Cost Recovery"],
            area["Monthly Cost Recovery"],
        ]
        if v is not None
    )
    total_other = sum(
        v
        for v in [
            occ["Monthly Other Income"],
            leased["Monthly Other Income"],
            vac["Monthly Other Income"],
            area["Monthly Other Income"],
        ]
        if v is not None
    )

    wide = {
        "Building ID": building_id,
        "Record Type": record_type,
        "Occupied Sqft": occ["Sqft"],
        "Leased/Unoccupied Sqft": leased["Sqft"],
        "Vacant Sqft": vac["Sqft"],
        "Area Included Not Counted Sqft": area["Sqft"],
        "Total Sqft": total_sqft,
        "Total GLA Sqft": total_sqft,
        "Total Monthly Base Rent": total_base,
        "Total Monthly Cost Recovery": total_cost,
        "Total Monthly Other Income": total_other,
    }

    detail = []
    for label in TOTAL_LABELS:
        d = by_label[label]
        detail.append(
            {
                "Building ID": building_id,
                "Record Type": record_type,
                "Category": label.replace(" Sqft", ""),
                "Percent": d["Percent"],
                "Units": d["Units"],
                "Sqft": d["Sqft"],
                "Monthly Base Rent": d["Monthly Base Rent"],
                "Monthly Cost Recovery": d["Monthly Cost Recovery"],
                "Monthly Other Income": d["Monthly Other Income"],
            }
        )

    return wide, detail


def reconstruct_page_lines(page, y_tol: float = 3.0, x_gap: float = 1.5) -> list[str]:
    """Rebuild text lines from character positions using content-stream order.

    This PDF draws overlapping text runs (occupant names overlap the date/number
    columns) at the same vertical position, which makes ``page.extract_text``
    scramble characters together (e.g. ``LLC5/1/2017`` or ``(P1la/1y/h2o0u2s0e)``).

    Characters that belong to the same drawing operation are consecutive in the
    PDF content stream, so we:
      1. cluster characters into visual rows by their ``top`` coordinate,
      2. inside each row, segment characters into runs that are both consecutive
         in content-stream order and horizontally adjacent, and
      3. order those runs left-to-right by their ``x0`` to rebuild a clean line.
    """
    chars = page.chars
    if not chars:
        return []

    rows: list[dict] = []
    for idx, c in sorted(enumerate(chars), key=lambda kc: (round(kc[1]["top"], 1), kc[1]["x0"])):
        placed = False
        for row in rows:
            if abs(row["top"] - c["top"]) <= y_tol:
                row["chars"].append((idx, c))
                row["top"] = (row["top"] * row["n"] + c["top"]) / (row["n"] + 1)
                row["n"] += 1
                placed = True
                break
        if not placed:
            rows.append({"top": c["top"], "n": 1, "chars": [(idx, c)]})

    rows.sort(key=lambda r: r["top"])

    lines: list[str] = []
    for row in rows:
        segs: list[dict] = []
        cur: Optional[dict] = None
        for _, c in sorted(row["chars"], key=lambda kc: kc[0]):
            if cur is None:
                cur = {"text": c["text"], "x0": c["x0"], "x1": c["x1"]}
            elif abs(c["x0"] - cur["x1"]) <= x_gap:
                cur["text"] += c["text"]
                cur["x1"] = c["x1"]
            else:
                segs.append(cur)
                cur = {"text": c["text"], "x0": c["x0"], "x1": c["x1"]}
        if cur is not None:
            segs.append(cur)

        segs.sort(key=lambda s: s["x0"])
        line = " ".join(s["text"] for s in segs).strip()
        if line:
            lines.append(line)

    return lines


def parse_pdf(pdf_file: Path) -> tuple[pd.DataFrame, pd.DataFrame, pd.DataFrame]:
    suite_records = []
    totals_wide_records = []
    totals_detail_records = []

    current_building = None
    current_section = "Unknown"

    with pdfplumber.open(str(pdf_file)) as pdf:
        lines = []
        for page in pdf.pages:
            lines.extend(reconstruct_page_lines(page))

    i = 0
    while i < len(lines):
        line = lines[i].strip()
        i += 1

        if not line:
            continue

        header_match = BUILDING_HEADER_RE.search(line)
        if header_match:
            new_building = header_match.group(1).strip()
            # Keep the section across repeated page headers for the same building
            # so page splits do not turn occupied/vacant rows into Unknown.
            if new_building != current_building:
                current_section = "Unknown"
            current_building = new_building
            continue

        if line in SECTION_HEADINGS:
            current_section = line
            continue

        if any(line.startswith(prefix) for prefix in SKIP_PREFIXES):
            continue

        if line.startswith("Grand Total:"):
            grand_block = []
            while i < len(lines):
                nxt = lines[i].strip()
                i += 1
                if not nxt:
                    continue
                if nxt.startswith("Report Id"):
                    break
                grand_block.append(nxt)
                if nxt.startswith("Total Sqft:"):
                    break
            wide, detail = parse_totals_block("GRAND_TOTAL", grand_block, "Grand Total Reported")
            totals_wide_records.append(wide)
            totals_detail_records.extend(detail)
            continue

        if line.startswith("Totals:"):
            block = [line]
            while i < len(lines):
                nxt = lines[i].strip()
                if not nxt:
                    i += 1
                    continue
                if nxt.startswith("Report Id"):
                    i += 1
                    break
                if BUILDING_HEADER_RE.search(nxt) or nxt.startswith("Grand Total:"):
                    break
                block.append(nxt)
                i += 1
                if nxt.startswith("Total Sqft:"):
                    break

            wide, detail = parse_totals_block(current_building or "", block, "Building Total")
            totals_wide_records.append(wide)
            totals_detail_records.extend(detail)
            continue

        if is_data_row(line, current_building):
            row = parse_suite_row(line, current_section)
            if row.get("Section") == "Unknown":
                # Page-split fallback: infer section from row content when heading is omitted.
                row["Section"] = (
                    "Vacant Suites" if str(row.get("Occupant Name", "")).strip().lower() == "vacant" else "Occupied Suites"
                )
            row = apply_row_fixes(row)
            suite_records.append(row)

    return (
        pd.DataFrame(suite_records),
        pd.DataFrame(totals_wide_records),
        pd.DataFrame(totals_detail_records),
    )


def build_reconciliation(df_totals_wide: pd.DataFrame) -> pd.DataFrame:
    num_cols = [
        "Occupied Sqft",
        "Leased/Unoccupied Sqft",
        "Vacant Sqft",
        "Area Included Not Counted Sqft",
        "Total Sqft",
        "Total GLA Sqft",
        "Total Monthly Base Rent",
        "Total Monthly Cost Recovery",
        "Total Monthly Other Income",
    ]

    bldg = df_totals_wide[df_totals_wide["Record Type"] == "Building Total"]
    reported = df_totals_wide[df_totals_wide["Record Type"] == "Grand Total Reported"]

    calc = bldg[num_cols].sum(numeric_only=True)
    rep = reported[num_cols].sum(numeric_only=True) if not reported.empty else pd.Series(dtype=float)

    rows = []
    for col in num_cols:
        c = float(calc.get(col, 0.0))
        r = float(rep.get(col, 0.0))
        diff = c - r
        rows.append(
            {
                "Metric": col,
                "Calculated Sum of Buildings": c,
                "Reported Grand Total": r,
                "Difference": diff,
                "Matches": "Yes" if abs(diff) <= 0.01 else "No",
            }
        )

    return pd.DataFrame(rows)


def save_output(
    df_suites: pd.DataFrame,
    df_totals_wide: pd.DataFrame,
    df_totals_detail: pd.DataFrame,
    df_recon: pd.DataFrame,
    out_file: Path,
) -> Path:
    out_file.parent.mkdir(parents=True, exist_ok=True)

    def write_to(path: Path) -> None:
        with pd.ExcelWriter(path, engine="openpyxl") as writer:
            df_suites.to_excel(writer, sheet_name="Suite Level", index=False)
            df_totals_wide.to_excel(writer, sheet_name="Building Totals", index=False)
            df_totals_detail.to_excel(writer, sheet_name="Totals Detail", index=False)
            df_recon.to_excel(writer, sheet_name="Grand Total Check", index=False)

    try:
        write_to(out_file)
        return out_file
    except PermissionError:
        ts = pd.Timestamp.now().strftime("%Y%m%d_%H%M%S")
        fallback = out_file.with_name(f"{out_file.stem}_{ts}{out_file.suffix}")
        write_to(fallback)
        return fallback


def main() -> None:
    pdf_file = Path(pdf_path)
    if not pdf_file.exists():
        raise FileNotFoundError(f"PDF not found: {pdf_file}")

    print(f"PDF Source: {pdf_file}")
    df_suites, df_totals_wide, df_totals_detail = parse_pdf(pdf_file)

    suite_cols = [
        "Building ID",
        "Suite ID",
        "Occupant Name",
        "Rent Start",
        "Expiration",
        "GLA Sqft",
        "Monthly Base Rent",
        "Annual Rate PSF",
        "Monthly Cost Recovery",
        "Monthly Other Income",
        "Section",
    ]
    for col in suite_cols:
        if col not in df_suites.columns:
            df_suites[col] = None
    df_suites = df_suites[suite_cols]

    totals_cols = [
        "Building ID",
        "Record Type",
        "Occupied Sqft",
        "Leased/Unoccupied Sqft",
        "Vacant Sqft",
        "Area Included Not Counted Sqft",
        "Total Sqft",
        "Total GLA Sqft",
        "Total Monthly Base Rent",
        "Total Monthly Cost Recovery",
        "Total Monthly Other Income",
    ]
    for col in totals_cols:
        if col not in df_totals_wide.columns:
            df_totals_wide[col] = None
    df_totals_wide = df_totals_wide[totals_cols]

    detail_cols = [
        "Building ID",
        "Record Type",
        "Category",
        "Percent",
        "Units",
        "Sqft",
        "Monthly Base Rent",
        "Monthly Cost Recovery",
        "Monthly Other Income",
    ]
    for col in detail_cols:
        if col not in df_totals_detail.columns:
            df_totals_detail[col] = None
    df_totals_detail = df_totals_detail[detail_cols]

    df_recon = build_reconciliation(df_totals_wide)

    print(f"Suite rows extracted: {len(df_suites)}")
    print(f"Building totals rows extracted: {len(df_totals_wide)}")
    print(f"Totals-detail rows extracted: {len(df_totals_detail)}")

    saved = save_output(df_suites, df_totals_wide, df_totals_detail, df_recon, Path(output_excel))
    print(f"Saved output to: {saved}")

    if not df_recon.empty:
        print("\nGrand total check:")
        print(df_recon.to_string(index=False))


if __name__ == "__main__":
    main()
