set -g fish_greeting

if status is-interactive
    fish_vi_key_bindings

    fish_add_path --prepend "$HOME/.local/bin"
    set -gx EDITOR (command -v nvim)

    set -g __fish_git_prompt_show_informative_status 1
    set -g __fish_git_prompt_char_stateseparator "⋮"
    set -g __fish_git_prompt_showdirtystate "no"
    set -g __fish_git_prompt_showupstream "informative"
    set -g __fish_git_prompt_shorten_branch_len 19
    set -g __fish_git_prompt_color_branch brmagenta
    set -g __fish_git_prompt_color_stagedstate yellow
    set -g __fish_git_prompt_color_invalidstate red
    set -g __fish_git_prompt_color_cleanstate brgreen

    if command -v mise &>/dev/null
        mise activate fish | source
    end

    if command -v fzf &>/dev/null
        fzf --fish | source
    end

    alias pacman "sudo pacman"
    alias ip "ip -c=always"

    if command -v lsd &>/dev/null
        alias ls="lsd --icon=never --group-directories-first"
    end
end
