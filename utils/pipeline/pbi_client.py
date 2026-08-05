"""Power BI REST client - runs DAX via `executeQueries` and returns a DataFrame."""

import re
import sys
from pathlib import Path

import pandas as pd
import requests

_PROJECT_ROOT = Path(__file__).resolve().parents[2]
if str(_PROJECT_ROOT) not in sys.path:
    sys.path.append(str(_PROJECT_ROOT))

from utils.config_util import Config
from utils.pipeline.pbi_auth import get_token

_API = "https://api.powerbi.com/v1.0/myorg"


class PowerBIError(RuntimeError):
    """Raised when the Power BI API returns an error."""


def run_dax(dax: str,
            workspace_id: str,
            dataset_id: str,
            cfg: Config | None = None,
            token: str | None = None) -> pd.DataFrame:
    """Execute a DAX query against a dataset and return the first result table."""
    cfg = cfg or Config()
    token = token or get_token(cfg)

    url = f"{_API}/groups/{workspace_id}/datasets/{dataset_id}/executeQueries"
    body = {
        "queries": [{"query": dax}],
        "serializerSettings": {"includeNulls": True},
    }

    resp = requests.post(
        url,
        headers={"Authorization": f"Bearer {token}",
                 "Content-Type": "application/json"},
        json=body,
        timeout=cfg.get_float("POWERBI", "RequestTimeout", 180),
    )

    if resp.status_code == 401:
        # token may have expired mid-run - retry once with a fresh one
        token = get_token(cfg, force_refresh=True)
        resp = requests.post(
            url,
            headers={"Authorization": f"Bearer {token}",
                     "Content-Type": "application/json"},
            json=body,
            timeout=cfg.get_float("POWERBI", "RequestTimeout", 180),
        )

    if resp.status_code != 200:
        raise PowerBIError(
            f"executeQueries failed [{resp.status_code}]\n"
            f"URL: {url}\nResponse: {resp.text[:2000]}"
        )

    payload = resp.json()
    try:
        table = payload["results"][0]["tables"][0]
    except (KeyError, IndexError) as exc:
        raise PowerBIError(f"Unexpected response shape: {payload}") from exc

    return pd.DataFrame(table.get("rows", []))


def clean_columns(df: pd.DataFrame, column_map: dict | None = None) -> pd.DataFrame:
    """Normalise DAX column names.

    DAX returns names like ``'Building Suites'[BuildingID]`` or ``[GLA Sqft]``.
    Keep only the part inside the final brackets, then apply ``column_map``
    so the names match what the comparison scripts expect.
    """
    def _strip(col: str) -> str:
        match = re.search(r"\[([^\]]+)\]\s*$", str(col))
        return (match.group(1) if match else str(col)).strip()

    df = df.rename(columns={c: _strip(c) for c in df.columns})
    if column_map:
        df = df.rename(columns={k: v for k, v in column_map.items() if k in df.columns})
    return df


def parse_column_map(raw: str | None) -> dict:
    """Parse ``ColumnMap = A=B; C=D`` from config into ``{'A': 'B', 'C': 'D'}``."""
    mapping = {}
    if not raw:
        return mapping
    for pair in str(raw).split(";"):
        pair = pair.strip()
        if not pair or "=" not in pair:
            continue
        src, dst = pair.split("=", 1)
        mapping[src.strip()] = dst.strip()
    return mapping


def list_tables(workspace_id: str, dataset_id: str,
                cfg: Config | None = None) -> pd.DataFrame:
    """Discovery helper - list dataset tables (for filling in the DAX)."""
    return run_dax("EVALUATE INFO.TABLES()", workspace_id, dataset_id, cfg)


def list_measures(workspace_id: str, dataset_id: str,
                  cfg: Config | None = None) -> pd.DataFrame:
    """Discovery helper - list dataset measures."""
    return run_dax("EVALUATE INFO.MEASURES()", workspace_id, dataset_id, cfg)


def list_columns(workspace_id: str, dataset_id: str,
                 cfg: Config | None = None) -> pd.DataFrame:
    """Discovery helper - list dataset columns."""
    return run_dax("EVALUATE INFO.COLUMNS()", workspace_id, dataset_id, cfg)

