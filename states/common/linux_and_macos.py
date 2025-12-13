from pathlib import Path
from common.utils import recursive_relative_symlink


def symlinks():
    recursive_relative_symlink(
        src="symlink/common/",
        dest=str(Path.home()),
    )


def apply():
    symlinks()
