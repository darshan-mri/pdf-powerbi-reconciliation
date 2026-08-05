"""Spec-driven PDF extraction engine.

Reads a :class:`~utils.pipeline.field_spec.Spec` and pulls the declared fields
out of the PDF. Supports two record models:

``row``    each record starts on a line matching ``record.start_patterns`` and
           absorbs continuation lines (CM Rent Roll style).
``block``  each record starts at a marker regex and runs to the next marker
           (CM Aged Delinquency style).

The engine returns both the records *and* a health report, which is what the
self-healer uses to decide whether the layout has drifted.
"""

import re
import sys
from pathlib import Path

import pandas as pd

_PROJECT_ROOT = Path(__file__).resolve().parents[2]
if str(_PROJECT_ROOT) not in sys.path:
    sys.path.append(str(_PROJECT_ROOT))

from utils.config_util import Config
from utils.pipeline.field_spec import FieldSpec, Spec

DATE_RE = re.compile(r"\d{1,2}/\d{1,2}/\d{4}")
# Two-decimal money pattern. Critical for PDFs where columns run together,
# e.g. "0.00112,937.10" must split into "0.00" and "112,937.10".
NUMBER_RE = re.compile(r"-?[\d,]*\d\.\d{2}")


class ExtractionError(RuntimeError):
    """Raised when the PDF cannot be read at all."""


# ------------------------------------------------------------------ text
def read_pdf_text(pdf_path: str | Path, engine: str = "pymupdf") -> str:
    """Extract raw text from a PDF using the requested engine."""
    pdf_path = Path(pdf_path)
    if not pdf_path.exists():
        raise ExtractionError(f"PDF not found: {pdf_path}")

    engine = (engine or "pymupdf").lower()

    if engine in ("pymupdf", "fitz"):
        try:
            import fitz
        except ImportError as exc:
            raise ExtractionError("pymupdf not installed (pip install pymupdf)") from exc
        with fitz.open(str(pdf_path)) as doc:
            return "\n".join(page.get_text("text") for page in doc)

    if engine == "pypdf2":
        from PyPDF2 import PdfReader
        reader = PdfReader(str(pdf_path))
        return "\n".join((page.extract_text() or "") for page in reader.pages)

    if engine == "pdfplumber":
        import pdfplumber
        with pdfplumber.open(str(pdf_path)) as pdf:
            return "\n".join((page.extract_text() or "") for page in pdf.pages)

    raise ExtractionError(f"Unknown PDF engine '{engine}'.")


# ------------------------------------------------------------------ casting
def _clean_number(value) -> float | None:
    if value is None:
        return None
    text = str(value).strip().replace(",", "")
    negative = text.startswith("(") and text.endswith(")")
    text = text.strip("()").strip()
    try:
        number = float(text)
    except ValueError:
        return None
    return -number if negative else number


def _apply_transform(value, transform: str | None):
    if value is None or not transform:
        return value
    text = str(value)
    if transform == "upper":
        return text.upper()
    if transform == "lower":
        return text.lower()
    if transform == "title":
        return text.title()
    if transform == "strip_commas":
        return text.replace(",", "")
    if transform == "collapse_space":
        return re.sub(r"\s+", " ", text).strip()
    return value


def _cast(value, field: FieldSpec):
    if value is None or value == "":
        return field.default
    if field.type in ("float", "int"):
        number = _clean_number(value)
        if number is None:
            return field.default
        return int(number) if field.type == "int" else number
    return _apply_transform(str(value).strip(), field.transform)


# ------------------------------------------------------------------ field extraction
def _extract_field(field: FieldSpec, ctx: dict):
    """Pull one field's raw value out of a record context."""
    text = ctx["text"]

    if field.strategy == "const":
        return field.default

    if field.strategy == "state":
        return ctx.get("state", field.default)

    if field.strategy == "token":
        tokens = ctx["tokens"]
        idx = field.index
        if -len(tokens) <= idx < len(tokens):
            return tokens[idx]
        return None

    if field.strategy == "date":
        dates = ctx["dates"]
        return dates[field.index] if field.index < len(dates) else None

    if field.strategy == "number":
        numbers = ctx["numbers"]
        return numbers[field.index] if field.index < len(numbers) else None

    if field.strategy == "regex":
        for pattern in field.patterns:
            try:
                match = re.search(pattern, text, re.IGNORECASE | re.MULTILINE)
            except re.error:
                continue
            if match:
                try:
                    return match.group(field.group)
                except (IndexError, re.error):
                    return match.group(0)
        return None

    return None


def _build_context(text: str, state: str | None,
                   number_re=NUMBER_RE, date_re=DATE_RE) -> dict:
    cleaned = re.sub(r"\s+", " ", text).strip()
    return {
        "text": text,
        "clean": cleaned,
        "tokens": cleaned.split(),
        "dates": [m.group() for m in date_re.finditer(text)],
        "numbers": [m.group() for m in number_re.finditer(text)],
        "state": state,
    }


def _scoped_context(ctx: dict, line_pattern: str, number_re, date_re) -> dict:
    """Restrict a record's context to only the lines matching ``line_pattern``.

    Lets one field read the 'Total:' line while another reads a header line.
    """
    try:
        rx = re.compile(line_pattern, re.IGNORECASE)
    except re.error:
        return ctx
    kept = [ln for ln in ctx["text"].splitlines() if rx.search(ln)]
    if not kept:
        return {**ctx, "text": "", "clean": "", "tokens": [],
                "dates": [], "numbers": []}
    return _build_context("\n".join(kept), ctx.get("state"), number_re, date_re)


def _record_from_context(spec: Spec, ctx: dict,
                         number_re=NUMBER_RE, date_re=DATE_RE) -> dict:
    record = {}
    for field in spec.fields:
        field_ctx = ctx
        if getattr(field, "line_pattern", None):
            field_ctx = _scoped_context(ctx, field.line_pattern, number_re, date_re)
        raw = _extract_field(field, field_ctx)
        record[field.name] = _cast(raw, field)
    return record


# ------------------------------------------------------------------ segmentation
def _compile_any(patterns) -> list:
    compiled = []
    for pattern in patterns or []:
        try:
            compiled.append(re.compile(pattern))
        except re.error:
            continue
    return compiled


def _matches_any(compiled, line: str) -> bool:
    return any(rx.search(line) for rx in compiled)


def _segment_rows(spec: Spec, lines: list) -> list:
    """Row mode: start a record on a start-pattern, absorb continuation lines."""
    cfg = spec.record
    starts = _compile_any(cfg.get("start_patterns"))
    noise = _compile_any(cfg.get("noise_patterns"))
    skip_contains = cfg.get("skip_contains", [])
    state_markers = cfg.get("state_markers", {})
    stop = _compile_any(cfg.get("stop_patterns"))

    if not starts:
        return []

    segments, buffer, state = [], None, cfg.get("default_state")

    for raw_line in lines:
        line = raw_line.strip()
        if not line:
            continue

        marker_hit = False
        for marker, value in state_markers.items():
            if marker in line:
                state = value
                marker_hit = True
                break
        if marker_hit:
            continue

        if any(token in line for token in skip_contains):
            continue
        if noise and _matches_any(noise, line):
            continue
        if stop and _matches_any(stop, line):
            if buffer:
                segments.append(buffer)
                buffer = None
            continue

        if _matches_any(starts, line):
            if buffer:
                segments.append(buffer)
            buffer = {"text": line, "state": state}
        elif buffer:
            buffer["text"] += " " + line

    if buffer:
        segments.append(buffer)
    return segments


def _segment_blocks(spec: Spec, lines: list) -> list:
    """Block mode: a record spans from one marker line to the next."""
    cfg = spec.record
    starts = _compile_any(cfg.get("start_patterns"))
    if not starts:
        return []

    segments, buffer = [], None
    for raw_line in lines:
        if _matches_any(starts, raw_line):
            if buffer:
                segments.append(buffer)
            buffer = {"text": raw_line, "state": None}
        elif buffer:
            buffer["text"] += "\n" + raw_line

    if buffer:
        segments.append(buffer)
    return segments


def _segment_block_end(spec: Spec, lines: list) -> list:
    """block_end mode: accumulate lines, close the record on an end marker.

    Suits reports where the identifying header comes first and the values
    arrive on a trailing summary line (e.g. "<Tenant> Total: ...").
    """
    cfg = spec.record
    ends = _compile_any(cfg.get("end_patterns"))
    resets = _compile_any(cfg.get("reset_patterns"))
    skip_contains = cfg.get("skip_contains", [])
    max_lines = int(cfg.get("max_block_lines", 400))

    if not ends:
        return []

    segments, buffer = [], []
    for raw_line in lines:
        line = raw_line.rstrip()
        if not line.strip():
            continue
        if any(token in line for token in skip_contains):
            continue

        buffer.append(line)

        if _matches_any(ends, line):
            segments.append({"text": "\n".join(buffer), "state": None})
            buffer = []
        elif resets and _matches_any(resets, line) and len(buffer) > max_lines:
            buffer = [line]
        elif len(buffer) > max_lines:
            buffer = buffer[-max_lines:]

    return segments


_SEGMENTERS = {
    "row": _segment_rows,
    "block": _segment_blocks,
    "block_end": _segment_block_end,
}


# ------------------------------------------------------------------ health
def assess(spec: Spec, df: pd.DataFrame) -> dict:
    """Score an extraction against the spec's validation rules."""
    validation = spec.validation or {}
    issues, fill_rates = [], {}

    row_count = len(df)
    min_rows = validation.get("min_rows", 1)
    if row_count < min_rows:
        issues.append(f"row_count {row_count} < min_rows {min_rows}")

    for field in spec.fields:
        if field.name not in df.columns:
            fill_rates[field.name] = 0.0
            issues.append(f"column '{field.name}' missing")
            continue
        column = df[field.name]
        filled = column.notna() & (column.astype(str).str.strip() != "")
        rate = float(filled.mean()) if row_count else 0.0
        fill_rates[field.name] = round(rate, 4)

        threshold = (validation.get("min_fill_rate", {}) or {}).get(field.name)
        if threshold is None and field.required:
            threshold = 0.95
        if threshold is not None and rate < threshold:
            issues.append(
                f"field '{field.name}' fill rate {rate:.2%} < required {threshold:.2%}")

    for field_name, rules in (validation.get("ranges", {}) or {}).items():
        if field_name not in df.columns:
            continue
        numeric = pd.to_numeric(df[field_name], errors="coerce").dropna()
        if numeric.empty:
            continue
        if "min" in rules and numeric.min() < rules["min"]:
            issues.append(f"field '{field_name}' min {numeric.min()} < {rules['min']}")
        if "max" in rules and numeric.max() > rules["max"]:
            issues.append(f"field '{field_name}' max {numeric.max()} > {rules['max']}")

    denominator = max(len(spec.fields), 1)
    score = sum(fill_rates.values()) / denominator if row_count else 0.0

    return {
        "healthy": not issues,
        "row_count": row_count,
        "fill_rates": fill_rates,
        "issues": issues,
        "score": round(score, 4),
    }


# ------------------------------------------------------------------ public API
def extract(spec: Spec,
            pdf_path: str | Path | None = None,
            cfg: Config | None = None,
            text: str | None = None) -> tuple:
    """Extract records for a spec.

    Returns
    -------
    (DataFrame, health_dict)
    """
    cfg = cfg or Config()

    # --- custom mode: delegate to a purpose-built parser -------------------
    # Used where PDF geometry (coordinate slicing, content-stream ordering,
    # cross-page lookback) cannot be expressed declaratively.
    if spec.mode == "custom":
        from utils.pipeline.adapters import resolve_handler

        handler_path = (spec.source or {}).get("handler")
        if not handler_path:
            raise ExtractionError(
                f"Spec '{spec.name}' uses mode 'custom' but declares no "
                f"source.handler.")
        if pdf_path is None:
            source_key = (spec.source or {}).get("config_key", "PDF")
            pdf_path = cfg.get(spec.report, source_key)

        handler = resolve_handler(handler_path)
        df = handler(pdf_path, cfg)
        if df is None:
            df = pd.DataFrame()
        df = pd.DataFrame(df)

        for column, pattern in (
                (spec.validation or {}).get("exclude_rows", {}) or {}).items():
            if column not in df.columns:
                continue
            try:
                mask = df[column].astype(str).str.contains(
                    pattern, case=False, regex=True, na=False)
            except re.error:
                continue
            df = df[~mask].reset_index(drop=True)

        missing = [c for c in spec.column_names if c not in df.columns]
        for col in missing:
            df[col] = None

        return df, assess(spec, df)

    if text is None:
        if pdf_path is None:
            source_key = (spec.source or {}).get("config_key", "PDF")
            pdf_path = cfg.get(spec.report, source_key)
        engine = (spec.source or {}).get("engine", "pymupdf")
        text = read_pdf_text(pdf_path, engine)

    lines = text.splitlines()
    segmenter = _SEGMENTERS.get(spec.mode, _segment_rows)
    segments = segmenter(spec, lines)

    number_re = NUMBER_RE
    date_re = DATE_RE
    if (spec.record or {}).get("number_pattern"):
        try:
            number_re = re.compile(spec.record["number_pattern"])
        except re.error:
            pass
    if (spec.record or {}).get("date_pattern"):
        try:
            date_re = re.compile(spec.record["date_pattern"])
        except re.error:
            pass

    records = []
    for segment in segments:
        ctx = _build_context(segment["text"], segment.get("state"),
                             number_re, date_re)
        record = _record_from_context(spec, ctx, number_re, date_re)

        required = spec.required_fields
        if required and all(
            record.get(name) in (None, "", spec.field(name).default)
            for name in required
        ):
            continue
        records.append(record)

    df = pd.DataFrame(records, columns=spec.column_names)

    # Drop non-data rows (e.g. building subtotal lines masquerading as records)
    for column, pattern in ((spec.validation or {}).get("exclude_rows", {}) or {}).items():
        if column not in df.columns:
            continue
        try:
            mask = df[column].astype(str).str.contains(
                pattern, case=False, regex=True, na=False)
        except re.error:
            continue
        df = df[~mask].reset_index(drop=True)

    drop_rules = (spec.validation or {}).get("drop_if_all_null", [])
    if drop_rules:
        present = [c for c in drop_rules if c in df.columns]
        if present:
            df = df.dropna(subset=present, how="all").reset_index(drop=True)

    return df, assess(spec, df)


def extract_report(report: str, cfg: Config | None = None) -> tuple:
    """Convenience: load the spec configured for a report and extract."""
    cfg = cfg or Config()
    spec = Spec.for_report(report, cfg)
    return extract(spec, cfg=cfg)









