from pathlib import Path
from pyinfra.operations import files


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
