set -g fish_greeting

set -ga PATH $HOME/.local/bin
set -gx EDITOR /usr/bin/nvim

if status is-interactive
    fish_vi_key_bindings

    set -gx TERM xterm-256color

    alias j="just"
    alias ls="ls --color=auto"
    alias ip="ip -c=always"
    alias pacman="sudo pacman"
    alias podman="sudo podman"

    if which rtx &>/dev/null
        rtx activate fish | source
    end
end
