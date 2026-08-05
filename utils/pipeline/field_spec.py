"""Declarative field specifications for PDF extraction.

A *spec* is a JSON file in ``schemas/`` that says **what to pull out of which
PDF** - no Python required. The extraction engine and the self-healer both read
it, so changing what gets extracted is a config change, not a code change.

Spec anatomy
------------
::

    {
      "name": "cm_roll",
      "version": 3,
      "report": "CM.ROLL",              # config.ini section
      "mode": "row",                    # "row" (line-based) | "block"
      "source": {"config_key": "PDF", "engine": "pymupdf"},
      "output": {"config_key": "ExtractedSuites", "sheet": "Unit Level"},
      "record": { ...how to find a record... },
      "fields": [ ...what to pull out... ],
      "validation": { ...what "good" looks like... }
    }

Field strategies
----------------
``token``   whitespace token at ``index``
``regex``   first ``patterns`` entry that matches, capture ``group``
``date``    the n-th ``dd/mm/yyyy`` match on the record
``number``  the n-th numeric match on the record
``state``   value of the current state marker (e.g. Occupied / Vacant)
``const``   literal value

Every pattern-based field may carry ``candidates`` - alternative patterns the
healer is allowed to try when the layout drifts.
"""

import copy
import json
import sys
from dataclasses import dataclass, field as dc_field
from datetime import datetime
from pathlib import Path

_PROJECT_ROOT = Path(__file__).resolve().parents[2]
if str(_PROJECT_ROOT) not in sys.path:
    sys.path.append(str(_PROJECT_ROOT))

from utils.config_util import Config

VALID_MODES = {"row", "block", "block_end", "custom"}
VALID_STRATEGIES = {"token", "regex", "date", "number", "state", "const", "custom"}
VALID_TYPES = {"str", "float", "int", "date"}


class SpecError(ValueError):
    """Raised when a spec file is malformed."""


@dataclass
class FieldSpec:
    name: str
    strategy: str = "token"
    index: int = 0
    group: int = 1
    patterns: list = dc_field(default_factory=list)
    candidates: list = dc_field(default_factory=list)
    type: str = "str"
    required: bool = False
    default: object = None
    transform: str | None = None       # e.g. "upper", "strip_commas"
    line_pattern: str | None = None    # restrict this field to matching lines
    description: str = ""

    @classmethod
    def from_dict(cls, data: dict) -> "FieldSpec":
        if "name" not in data:
            raise SpecError(f"Field is missing 'name': {data}")
        known = {f for f in cls.__dataclass_fields__}
        clean = {k: v for k, v in data.items() if k in known}
        spec = cls(**clean)
        if spec.strategy not in VALID_STRATEGIES:
            raise SpecError(
                f"Field '{spec.name}': unknown strategy '{spec.strategy}'. "
                f"Valid: {sorted(VALID_STRATEGIES)}")
        if spec.type not in VALID_TYPES:
            raise SpecError(
                f"Field '{spec.name}': unknown type '{spec.type}'. "
                f"Valid: {sorted(VALID_TYPES)}")
        if spec.strategy == "regex" and not spec.patterns:
            raise SpecError(f"Field '{spec.name}': strategy 'regex' needs 'patterns'.")
        return spec

    def to_dict(self) -> dict:
        return {k: getattr(self, k) for k in self.__dataclass_fields__}


@dataclass
class Spec:
    name: str
    report: str
    mode: str = "row"
    version: int = 1
    source: dict = dc_field(default_factory=dict)
    output: dict = dc_field(default_factory=dict)
    record: dict = dc_field(default_factory=dict)
    fields: list = dc_field(default_factory=list)
    validation: dict = dc_field(default_factory=dict)
    history: list = dc_field(default_factory=list)
    path: Path | None = None

    # ------------------------------------------------------------ loading
    @classmethod
    def from_dict(cls, data: dict, path: Path | None = None) -> "Spec":
        for required in ("name", "report"):
            if required not in data:
                raise SpecError(f"Spec is missing required key '{required}'.")
        mode = data.get("mode", "row")
        if mode not in VALID_MODES:
            raise SpecError(f"Unknown mode '{mode}'. Valid: {sorted(VALID_MODES)}")

        fields = [FieldSpec.from_dict(f) for f in data.get("fields", [])]
        if not fields:
            raise SpecError(f"Spec '{data['name']}' defines no fields.")

        names = [f.name for f in fields]
        dupes = {n for n in names if names.count(n) > 1}
        if dupes:
            raise SpecError(f"Duplicate field names in '{data['name']}': {sorted(dupes)}")

        return cls(
            name=data["name"],
            report=data["report"],
            mode=mode,
            version=int(data.get("version", 1)),
            source=data.get("source", {}),
            output=data.get("output", {}),
            record=data.get("record", {}),
            fields=fields,
            validation=data.get("validation", {}),
            history=data.get("history", []),
            path=path,
        )

    @classmethod
    def load(cls, path: str | Path) -> "Spec":
        path = Path(path)
        if not path.is_absolute():
            path = _PROJECT_ROOT / path
        if not path.exists():
            raise SpecError(f"Spec file not found: {path}")
        with open(path, "r", encoding="utf-8") as handle:
            return cls.from_dict(json.load(handle), path=path)

    @classmethod
    def for_report(cls, report: str, cfg: Config | None = None) -> "Spec":
        """Load the spec referenced by ``[<report>] Schema`` in config.ini."""
        cfg = cfg or Config()
        schema_path = cfg.get(report, "Schema")
        return cls.load(schema_path)

    # ------------------------------------------------------------ saving
    def to_dict(self) -> dict:
        return {
            "name": self.name,
            "version": self.version,
            "report": self.report,
            "mode": self.mode,
            "source": self.source,
            "output": self.output,
            "record": self.record,
            "fields": [f.to_dict() for f in self.fields],
            "validation": self.validation,
            "history": self.history,
        }

    def save(self, path: str | Path | None = None, backup: bool = True) -> Path:
        """Write the spec to disk, keeping a timestamped backup of the old one."""
        target = Path(path) if path else self.path
        if target is None:
            raise SpecError("No path to save the spec to.")
        if not target.is_absolute():
            target = _PROJECT_ROOT / target
        target.parent.mkdir(parents=True, exist_ok=True)

        if backup and target.exists():
            versions = target.parent / "versions"
            versions.mkdir(exist_ok=True)
            stamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            backup_path = versions / f"{target.stem}_v{self.version}_{stamp}.json"
            backup_path.write_text(target.read_text(encoding="utf-8"),
                                   encoding="utf-8")

        with open(target, "w", encoding="utf-8") as handle:
            json.dump(self.to_dict(), handle, indent=2)
        self.path = target
        return target

    # ------------------------------------------------------------ helpers
    def clone(self) -> "Spec":
        copied = Spec.from_dict(copy.deepcopy(self.to_dict()), path=self.path)
        return copied

    def field(self, name: str) -> FieldSpec | None:
        return next((f for f in self.fields if f.name == name), None)

    @property
    def column_names(self) -> list:
        return [f.name for f in self.fields]

    @property
    def required_fields(self) -> list:
        return [f.name for f in self.fields if f.required]

    def record_note(self, note: str) -> None:
        """Append an audit entry (used by the healer)."""
        self.history.append({
            "timestamp": datetime.now().isoformat(timespec="seconds"),
            "version": self.version,
            "note": note,
        })

    def __repr__(self) -> str:
        return (f"<Spec {self.name} v{self.version} "
                f"report={self.report} mode={self.mode} "
                f"fields={len(self.fields)}>")


def list_specs(cfg: Config | None = None) -> list:
    """Every spec found in the configured schema directory."""
    cfg = cfg or Config()
    schema_dir = Path(cfg.get("PIPELINE", "SchemaDir", default="schemas"))
    if not schema_dir.is_absolute():
        schema_dir = _PROJECT_ROOT / schema_dir
    if not schema_dir.exists():
        return []
    specs = []
    for file in sorted(schema_dir.glob("*.json")):
        try:
            specs.append(Spec.load(file))
        except SpecError:
            continue
    return specs




