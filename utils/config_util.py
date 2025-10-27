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
        Traverse upwards until a folder with name `project_name` is found.
        """
        path = Path(__file__).resolve().parent
        while path != path.parent:
            if path.name == project_name:
                return path
            path = path.parent
        raise FileNotFoundError(f"Project root '{project_name}' not found.")

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
            self._config = configparser.ConfigParser()
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
