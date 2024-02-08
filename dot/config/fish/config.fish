set -g fish_greeting

set -ga PATH $HOME/.local/bin
set -gx EDITOR (which nvim)

if status is-interactive
    fish_vi_key_bindings

    alias j="just"
    alias ls="ls --color=auto"
    alias mr="mise run --"

    # system specific things
    set linux "false"
    if test (uname) = "Linux"
        set linux "true"
    end

    if test "$linux" = "true"
        set -gx TERM xterm-256color
        set -ga PATH $XDG_DATA_HOME/mise/installs/1password-cli/latest/bin

        if which mise &>/dev/null
            mise activate fish | source
        end

        alias ip="ip -c=always"
        alias pacman="sudo pacman"
        alias podman="sudo podman"
    else
        set -ga PATH /opt/homebrew/bin
        set -gx HOMEBREW_NO_AUTO_UPDATE 1

        alias ls="gls --color=auto --hide Desktop --hide Downloads \
            --hide Movies --hide Pictures --hide Documents \
            --hide Library --hide Music --hide Public"
    end
end
