from enum import Enum
from pathlib import Path
from subprocess import check_output
from typing import Self
from pyinfra.operations import files


class Machine(Enum):
    MACK = "mack"
    LORKHAN = "lorkhan"
    DWEMER = "dwemer"

    @classmethod
    def determine(cls) -> Self:
        uname = check_output(["uname"]).decode("utf-8").strip()
        if uname == "Linux":
            with Path("/etc/hostname").open() as fp:
                hostname = fp.read().strip()
            return cls(hostname)
        elif uname == "Darwin":
            return cls.MACK
        raise ValueError("unknown uname")


def recursive_relative_symlink(
    src: Path | str,
    dest: Path | str,
) -> None:
    src, dest = Path(src).absolute(), Path(dest).absolute()

    for src_child in src.iterdir():
        relative_path = src_child.relative_to(src)
        link_path = dest / relative_path

        if src_child.is_dir():
            recursive_relative_symlink(src=src_child, dest=link_path)
        else:
            files.link(
                name=f"Config link {link_path}",
                path=str(link_path),
                target=str(src_child),
            )
