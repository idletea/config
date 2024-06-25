set -g fish_greeting

function __linux
    set -gx TERM xterm-256color
    set -gx EDITOR /usr/bin/nvim
    set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
    set -gx DOCKER_HOST_PATH "$XDG_RUNTIME_DIR/podman/podman.sock"
    set -gx DOCKER_HOST "unix://$DOCKER_HOST_PATH"

    alias pacman "sudo pacman"
    alias ip "ip -c=always"
end

function __macos
    set -ax PATH /opt/homebrew/bin
    set -ax PATH /Users/tkerr/.local/share/cargo/bin
    set -ax PATH /Users/tkerr/devex/bin

    set -gx HOMEBREW_NO_AUTO_UPDATE 1
    set -gx DEVEX_SHELLENV_LOADED 1

    set -l prefix (brew --prefix)
    set -l gcs_inc "$prefix/share/google-cloud-sdk/path.fish.inc"
    if test -e "$gcs_inc"; source "$gcs_inc"; end

    alias ls="gls --color=auto --hide Desktop --hide Downloads \
        --hide Movies --hide Picture --hide Documents \
        --hide Library --hide Music --hide Public"
end

if status is-interactive
    fish_vi_key_bindings

    alias pacman "sudo pacman"

    set -ax PATH "$HOME/.local/bin"
    set -gx PYTHONBREAKPOINT "ipdb.set_trace"

    if command -v mise &>/dev/null
        mise activate fish | source
    end
    if command -v fzf &>/dev/null
        fzf --fish | source
    end

    if test (uname) = "Linux"
        __linux
    else
        __macos
    end
end
