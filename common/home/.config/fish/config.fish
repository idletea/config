set -g fish_greeting

if status is-interactive
    fish_vi_key_bindings

    alias pacman "sudo pacman"

    set -ga PATH "$HOME/.local/bin"

    if command -v mise &>/dev/null
        mise activate fish | source
    end
end
