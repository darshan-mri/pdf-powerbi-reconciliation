import os
import configparser
from pathlib import Path

class Config:
    _instance = None

    def __new__(cls, config_file='config.ini'):
        if cls._instance is None:
            cls._instance = super(Config, cls).__new__(cls)
            # Resolve config file relative to project root
            cls._instance._config_file = cls._instance._resolve_path(config_file)
            cls._instance._config = None
        return cls._instance

    # ------------------------
    # Project root detection
    # ------------------------
    @staticmethod
    def _get_project_root(project_name="PDFValidation") -> Path:
        """
        Traverse upwards to find the project root.

        Priority:
        1. A directory containing `config.ini`
        2. A directory with both `utils/` and `requirements.txt`
        3. Backward-compatible fallback to explicit folder name
        """
        path = Path(__file__).resolve().parent
        while path != path.parent:
            if (path / "config.ini").exists():
                return path
            if (path / "utils").is_dir() and (path / "requirements.txt").exists():
                return path
            if path.name == project_name:
                return path
            path = path.parent
        raise FileNotFoundError("Project root not found (expected config.ini at root).")

    # ------------------------
    # Path resolver
    # ------------------------
    @classmethod
    def _resolve_path(cls, rel_path: str) -> Path:
        """
        Resolve a path relative to the project root.
        """
        root = cls._get_project_root()
        abs_path = root / rel_path
        return abs_path

    # ------------------------
    # Load config
    # ------------------------
    def _load_config(self):
        if self._config is None:
            # interpolation=None so DAX/regex values containing '%' or '$' are safe
            self._config = configparser.ConfigParser(interpolation=None)
            if os.path.exists(self._config_file):
                self._config.read(self._config_file)
            else:
                raise FileNotFoundError(f"Config file '{self._config_file}' not found.")

    # ------------------------
    # Get value
    # ------------------------
    def get(self, section, key, default=None, resolve_path=True):
        """
        Get a config value. If resolve_path=True and it looks like a path, resolve relative to project root.
        """
        self._load_config()
        try:
            value = self._config.get(section, key)
            if resolve_path and ("/" in value or "\\" in value):
                return self._resolve_path(value)
            return value
        except (configparser.NoSectionError, configparser.NoOptionError) as e:
            if default is not None:
                return default
            else:
                raise KeyError(f"Section '{section}' or key '{key}' not found in config.") from e
        except configparser.Error as e:
            raise KeyError(f"Error reading config: {e}")

    # ------------------------
    # Raw value (never treated as a path)
    # ------------------------
    def get_raw(self, section, key, default=None):
        """Get a config value verbatim - no path resolution.

        Use for GUIDs, DAX queries, regex patterns and any value that may
        contain '/' or '\\' but is NOT a file path.
        """
        try:
            return self.get(section, key, resolve_path=False)
        except KeyError:
            return default

    # ------------------------
    # Booleans / section helpers
    # ------------------------
    def get_bool(self, section, key, default=False):
        val = self.get_raw(section, key)
        if val is None or str(val).strip() == "":
            return default
        return str(val).strip().lower() in ("1", "true", "yes", "on")

    def get_float(self, section, key, default=0.0):
        val = self.get_raw(section, key)
        try:
            return float(str(val))
        except (TypeError, ValueError):
            return default

    def has_section(self, section) -> bool:
        self._load_config()
        return self._config.has_section(section)

    def section_items(self, section) -> dict:
        """All key/value pairs of a section as a plain dict (unresolved)."""
        self._load_config()
        if not self._config.has_section(section):
            return {}
        return dict(self._config.items(section))
