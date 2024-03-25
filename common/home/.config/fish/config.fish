set -g fish_greeting

function __linux
    set -gx TERM xterm-256color
    set -gx EDITOR (which nvim)
    set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket

    alias pacman="sudo pacman"
    alias ip="ip -c=always"
end

function __macos
    set -ga PATH /opt/homebrew/bin
    set -ga PATH /Users/tkerr/.local/share/cargo/bin
    set -gx HOMEBREW_NO_AUTO_UPDATE 1

    alias ls="gls --color=auto --hide Desktop --hide Downloads \
        --hide Movies --hide Pictures --hide Documents \
        --hide Library --hide Music --hide Public"
end

if status is-interactive
    fish_vi_key_bindings

    set -ga PATH $HOME/.local/bin
    set -gx PYTHONBREAKPOINT ipdb.set_trace

    alias mr="mise run --"
    if which mise &>/dev/null
        mise activate fish | source
    end

    if test (uname) = "Linux"
        __linux
    else
        __macos
    end
end
