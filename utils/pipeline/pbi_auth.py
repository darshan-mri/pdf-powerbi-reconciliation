"""Power BI token acquisition.

Every auth mode returns a bearer token for the Power BI REST API, so the rest
of the pipeline is identical no matter how you authenticate.

Modes (set ``[POWERBI] AuthMode``):
    client_secret     Service principal + secret (secret read from an env var)
    certificate       Service principal + X.509 cert   -- prod-safe on-prem
    key_vault         Service principal, secret pulled from Azure Key Vault
    managed_identity  No credential at all             -- prod-safe in Azure
    device_code       Interactive sign-in              -- local/manual use only
"""

import os
import sys
from pathlib import Path

import requests

_PROJECT_ROOT = Path(__file__).resolve().parents[2]
if str(_PROJECT_ROOT) not in sys.path:
    sys.path.append(str(_PROJECT_ROOT))

from utils.config_util import Config

PBI_SCOPE = "https://analysis.windows.net/powerbi/api/.default"
PBI_SCOPE_DELEGATED = ["https://analysis.windows.net/powerbi/api/Dataset.Read.All"]
_AUTHORITY = "https://login.microsoftonline.com/{tenant}"


class AuthError(RuntimeError):
    """Raised when a token could not be acquired."""


# ---------------------------------------------------------------- helpers
def _require(value, what):
    if not value or str(value).startswith("<"):
        raise AuthError(
            f"[POWERBI] {what} is not configured in config.ini "
            f"(current value: {value!r})."
        )
    return str(value).strip()


def _resolve_secret(cfg: Config) -> str:
    """Secret from config, else from the env var named by ClientSecretEnv."""
    secret = cfg.get_raw("POWERBI", "ClientSecret", default="") or ""
    if not secret:
        env_name = cfg.get_raw("POWERBI", "ClientSecretEnv",
                               default="PBI_CLIENT_SECRET")
        secret = os.environ.get(env_name, "")
        if not secret:
            raise AuthError(
                f"No client secret found. Set the environment variable "
                f"'{env_name}' (PowerShell: setx {env_name} \"<secret>\") "
                f"or fill [POWERBI] ClientSecret."
            )
    return secret


# ---------------------------------------------------------------- modes
def _token_client_secret(cfg: Config) -> str:
    tenant = _require(cfg.get_raw("POWERBI", "TenantId"), "TenantId")
    client_id = _require(cfg.get_raw("POWERBI", "ClientId"), "ClientId")
    secret = _resolve_secret(cfg)

    resp = requests.post(
        f"{_AUTHORITY.format(tenant=tenant)}/oauth2/v2.0/token",
        data={
            "grant_type": "client_credentials",
            "client_id": client_id,
            "client_secret": secret,
            "scope": PBI_SCOPE,
        },
        timeout=cfg.get_float("POWERBI", "RequestTimeout", 180),
    )
    if resp.status_code != 200:
        raise AuthError(f"Token request failed [{resp.status_code}]: {resp.text}")
    return resp.json()["access_token"]


def _token_certificate(cfg: Config) -> str:
    try:
        import msal
    except ImportError as exc:  # pragma: no cover
        raise AuthError("certificate mode requires 'msal' (pip install msal)") from exc

    tenant = _require(cfg.get_raw("POWERBI", "TenantId"), "TenantId")
    client_id = _require(cfg.get_raw("POWERBI", "ClientId"), "ClientId")
    cert_path = Path(_require(cfg.get_raw("POWERBI", "CertPath"), "CertPath"))
    thumbprint = _require(cfg.get_raw("POWERBI", "CertThumbprint"), "CertThumbprint")

    if not cert_path.is_absolute():
        cert_path = _PROJECT_ROOT / cert_path
    if not cert_path.exists():
        raise AuthError(f"Certificate not found: {cert_path}")

    app = msal.ConfidentialClientApplication(
        client_id,
        authority=_AUTHORITY.format(tenant=tenant),
        client_credential={
            "thumbprint": thumbprint,
            "private_key": cert_path.read_text(encoding="utf-8"),
        },
    )
    result = app.acquire_token_for_client(scopes=[PBI_SCOPE])
    if "access_token" not in result:
        raise AuthError(f"Certificate auth failed: {result.get('error_description')}")
    return result["access_token"]


def _token_managed_identity(cfg: Config) -> str:
    try:
        from azure.identity import DefaultAzureCredential
    except ImportError as exc:  # pragma: no cover
        raise AuthError(
            "managed_identity mode requires 'azure-identity' "
            "(pip install azure-identity)"
        ) from exc
    return DefaultAzureCredential().get_token(PBI_SCOPE).token


def _token_key_vault(cfg: Config) -> str:
    try:
        from azure.identity import DefaultAzureCredential
        from azure.keyvault.secrets import SecretClient
    except ImportError as exc:  # pragma: no cover
        raise AuthError(
            "key_vault mode requires 'azure-identity' and 'azure-keyvault-secrets'"
        ) from exc

    vault_url = _require(cfg.get_raw("POWERBI", "KeyVaultUrl"), "KeyVaultUrl")
    secret_name = _require(cfg.get_raw("POWERBI", "KeyVaultSecretName"),
                           "KeyVaultSecretName")
    tenant = _require(cfg.get_raw("POWERBI", "TenantId"), "TenantId")
    client_id = _require(cfg.get_raw("POWERBI", "ClientId"), "ClientId")

    kv = SecretClient(vault_url=vault_url, credential=DefaultAzureCredential())
    secret = kv.get_secret(secret_name).value

    resp = requests.post(
        f"{_AUTHORITY.format(tenant=tenant)}/oauth2/v2.0/token",
        data={
            "grant_type": "client_credentials",
            "client_id": client_id,
            "client_secret": secret,
            "scope": PBI_SCOPE,
        },
        timeout=cfg.get_float("POWERBI", "RequestTimeout", 180),
    )
    if resp.status_code != 200:
        raise AuthError(f"Token request failed [{resp.status_code}]: {resp.text}")
    return resp.json()["access_token"]


def _token_device_code(cfg: Config) -> str:
    """Interactive - NOT for unattended production runs."""
    try:
        import msal
    except ImportError as exc:  # pragma: no cover
        raise AuthError("device_code mode requires 'msal' (pip install msal)") from exc

    tenant = _require(cfg.get_raw("POWERBI", "TenantId"), "TenantId")
    client_id = _require(cfg.get_raw("POWERBI", "ClientId"), "ClientId")

    cache_path = _PROJECT_ROOT / cfg.get_raw(
        "POWERBI", "TokenCache", default=".pbi_token_cache.json")
    cache = msal.SerializableTokenCache()
    if cache_path.exists():
        cache.deserialize(cache_path.read_text(encoding="utf-8"))

    app = msal.PublicClientApplication(
        client_id, authority=_AUTHORITY.format(tenant=tenant), token_cache=cache)

    result = None
    accounts = app.get_accounts()
    if accounts:
        result = app.acquire_token_silent(PBI_SCOPE_DELEGATED, account=accounts[0])

    if not result:
        flow = app.initiate_device_flow(scopes=PBI_SCOPE_DELEGATED)
        if "user_code" not in flow:
            raise AuthError(f"Device flow failed: {flow}")
        print(flow["message"], flush=True)
        result = app.acquire_token_by_device_flow(flow)

    if cache.has_state_changed:
        cache_path.write_text(cache.serialize(), encoding="utf-8")

    if "access_token" not in result:
        raise AuthError(f"Device-code auth failed: {result.get('error_description')}")
    return result["access_token"]


_MODES = {
    "client_secret": _token_client_secret,
    "certificate": _token_certificate,
    "managed_identity": _token_managed_identity,
    "key_vault": _token_key_vault,
    "device_code": _token_device_code,
}

_TOKEN_CACHE: dict = {}


def get_token(cfg: Config | None = None, force_refresh: bool = False) -> str:
    """Acquire a Power BI bearer token using the configured AuthMode."""
    cfg = cfg or Config()
    mode = (cfg.get_raw("POWERBI", "AuthMode", default="client_secret")
            or "client_secret").strip().lower()

    if mode not in _MODES:
        raise AuthError(
            f"Unknown AuthMode '{mode}'. Valid: {', '.join(sorted(_MODES))}")

    if not force_refresh and mode in _TOKEN_CACHE:
        return _TOKEN_CACHE[mode]

    token = _MODES[mode](cfg)
    _TOKEN_CACHE[mode] = token
    return token

