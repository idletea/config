XDG_BASHRC="\${HOME}/.config/bash/bashrc";
if [[ -f "\${XDG_BASHRC}" ]]; then
    source "\${XDG_BASHRC}";
fi
