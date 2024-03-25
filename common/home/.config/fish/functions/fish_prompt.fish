function fish_prompt
    set -f last_status "$status"
    printf "%s%s%s" \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)

    ##########
    ## context

    set -f __git_toplevel (basename \
        (git rev-parse --show-toplevel 2>/dev/null) \
        2>/dev/null)

    set -f __branch (git branch --show-current 2>/dev/null)
    if test -n "$__git_toplevel"; \
            and test -z "$__branch"; \
            and test (git rev-parse --symbolic-full-name HEAD) = "HEAD"
        set -f __branch "|detached|"
    end
    if test -n "$__branch"; and test "$__branch" != "|detached|"
        set __issue_parts (string match \
            --regex "(feature|bug|chore)/(sc-\d+)/(.*)" $__branch \
            | tail -n 3)
        set -f __issue_type $__issue_parts[1]
        set -f __issue_id $__issue_parts[2]
        set -f __issue_name $__issue_parts[3]
    end

    ###############
    ## build prompt

    if test -n "$VIRTUAL_ENV"
        if test "$POETRY_ACTIVE" = 1; and test -n "$__git_toplevel"
            set -f name "|$__git_toplevel|"
        else
            pushd $VIRTUAL_ENV
            set -f __venv_git_toplevel (git rev-parse --show-toplevel 2>/dev/null)
            popd
            if test -n "$__venv_git_toplevel"
                set -f name (basename $__venv_git_toplevel)
            else
                set -f name (basename $VIRTUAL_ENV)
            end
        end

        printf " %s$name%s" \
            (set_color yellow) (set_color normal)
    end

    if test -n "$__branch"
        if test -n "$__issue_id"
            set -l short_name (string shorten --max 18 --left "$__issue_name")
            printf " |$__issue_id/$short_name|"
        else
            printf " $__branch"
        end
    end

    if test -n "$KUBECTL_NAMESPACE"
        printf " %s󱃾$KUBECTL_NAMESPACE%s" \
            (set_color -o blue) (set_color normal)
    end

    if which mise &>/dev/null
        set -l mise_configs (mise config ls --no-header | wc -l)
        if test $mise_configs -gt "1"
            printf " %smise%s" \
                (set_color -o cyan) (set_color normal)
        end
    end

    if not test "$last_status" = "0"
        printf " %s[$last_status]%s> " \
            (set_color $fish_color_status) (set_color normal)
    else
        printf " > "
    end
end
