function platform_config
    set -gx EDITOR (command -v nvim)
    set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"

    alias pacman "sudo pacman"
    alias ip "ip -c=always"
end
