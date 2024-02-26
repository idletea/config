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
            if test "$POETRY_ACTIVE" = "1"
                set -l base (basename $VIRTUAL_ENV)
                set -l parts (string split "-" $base)
                set -l poetry_suffix "-$parts[-3]-$parts[-2]-$parts[-1]"
                set -f name "|"(string replace -- "$poetry_suffix" "" $base)"|"
            else
                set -f name (basename $VIRTUAL_ENV)
            end
        end
        printf " %s$name%s" \
            (set_color yellow) (set_color normal)
    end

    set -f __branch (git branch --show-current 2>/dev/null)
    if test -n "$__branch"
        set issue_parts (string match \
            --regex "(feature|bug|chore)/(sc-\d+)/(.*)" $__branch \
            | tail -n 3)
        set issue_type $issue_parts[1]
        set issue_id $issue_parts[2]
        set issue_name $issue_parts[3]

        if test -n "$issue_id"
            printf " |$issue_id|"
        else
            printf " $__branch"
        end
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
