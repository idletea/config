function fish_prompt
    set -f last_status "$status"
    printf "%s%s%s" \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)

    if test -n "$VIRTUAL_ENV"
        pushd $VIRTUAL_ENV
        set -f __git_toplevel (git rev-parse --show-toplevel 2>/dev/null)
        popd
        if test -n "$__git_toplevel"
            set -f name (basename $__git_toplevel)
        else
            set -f name (basename $VIRTUAL_ENV)
        end
        printf " %s$name%s" \
            (set_color yellow) (set_color normal)
    end

    set -f __branch (git branch --show-current 2>/dev/null)
    if test -n "$__branch"
        printf " $__branch"
    end

    if test -n "$KUBECTL_NAMESPACE"
        printf " %s󱃾$KUBECTL_NAMESPACE%s" \
            (set_color -o blue) (set_color normal)
    end

    set -l mise_configs (mise config ls --no-header | wc -l)
    if test $mise_configs -gt "1"
        printf " %smise%s" \
            (set_color -o cyan) (set_color normal)
    end

    if not test "$last_status" = "0"
        printf " %s[$last_status]%s> " \
            (set_color $fish_color_status) (set_color normal)
    else
        printf " > "
    end
end
