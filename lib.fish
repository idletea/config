#!/usr/bin/fish

function __msg
    argparse 'section' 'heading' 'info' 'warn' 'error' 'noop' 'eval' \
        -- $argv; or return
    if test -n "$_flag_heading"
        printf "%s[- %s -]%s\n" \
            (set_color -o white) "$argv" (set_color reset)
    else if test -n "$_flag_info"
        printf "%s[.] %s%s\n" \
            (set_color -o white) "$argv" (set_color reset)
    else if test -n "$_flag_warn"
        printf "%s[!] %s%s\n" \
            (set_color -o yellow) "$argv" (set_color reset)
    else if test -n "$_flag_error"
        printf "%s[x] %s%s\n" \
            (set_color -o red) "$argv" (set_color reset)
    else if test -n "$_flag_noop"
        printf "%s[-] %s%s\n" \
            (set_color --dim) "$argv" (set_color reset)
    else if test -n "$_flag_eval"
        printf "%s[\$] %s%s%s\n" \
            (set_color -o cyan) (set_color -o white) \
            "$argv" (set_color reset)
        if not fish -c "$argv"
            __msg --error "exec failure"
        end
    else
        __msg --error "no valid flag passed"
        return 1
    end
end

function __pacman_packages_install_query
    set -f packages $argv

    if pacman -Q $argv &>/dev/null
        return 0
    end

    set -g __pacman_pacakges_present
    set -g __pacman_packages_missing
    for package in $packages
        if pacman -Q $package &>/dev/null
            set -ga __pacman_packages_present $package
        else
            set -ga __pacman_packages_missing $package
        end
    end
    return 1
end

function __pacman_install
    set -f packages $argv

    if __pacman_packages_install_query $packages
        __msg --noop "packages already installed"
        return 0
    end

    if test (count $__pacman_packages_present) -gt 0
        __msg --noop "packages already installed: $__pacman_packages_present"
    end
    __msg --eval "sudo pacman -S --noconfirm $__pacman_packages_missing"
end

function __pacman_aur_install
    # TODO: actually do installs/updates, not just warn on uninstalled
    set -f packages $argv

    if __pacman_packages_install_query $packages
        __msg --noop "aur packages already installed"
        return 0
    end

    if test (count $__pacman_packages_present) -gt 0
        __msg --noop "aur packages already installed: $__pacman_packages_present"
    end
    __msg --warn "manual aur install required: $__pacman_packages_missing"
end

function __sys_file -a local_path sys_path
    #!/usr/bin/fish
    if sudo test -e "$sys_path"
        set -l expect (md5sum $local_path | awk '{print $1}')
        set -l actual (sudo md5sum $sys_path | awk '{print $1}')
        if test "$expect" = "$actual"
            __msg --noop "$sys_path already present"
        else
            __msg --error "$sys_path exists, but is out of sync"
            return 1
        end
    else
        __msg --eval \
            "sudo cp $local_path $sys_path; and sudo chown root:root $sys_path"
    end
end

function __link_recursive -a target_path
    for path in (fd --hidden . "$target_path")
        set -l relpath (string replace --regex "^$target_path\/?" "" "$path")
        set -l linkpath (echo "$HOME/$relpath")
        set -l fullpath (realpath $path)
        if test -d "$fullpath"
            if not test -e "$linkpath"
                __msg --eval "mkdir -p $linkpath"
            else if not test -d "$linkpath"
                __msg --error "$linkpath is not a directory"
            end
        else
            if test -h "$linkpath"
                # TODO: check it's the *right* link
                __msg --noop "$linkpath already symlinked"
            else
                __msg --eval "ln -s $fullpath $linkpath"
            end
        end
    end
end

function __systemd_user_enable -a unit
    if not test -e "$HOME/.config/systemd/user/default.target.wants/$unit"
        __msg --eval "systemctl --user enable --now $unit"
    else
        __msg --noop "$unit already enabled"
    end
end

function __brew_packages_install_query
    set -f packages $argv

    set -g __brew_pacakges_present
    set -g __brew_packages_missing
    for package in $packages
        set -l separated (string split "/" "$package"); or true
        set -l name "$separated[-1]"
        if test -e "/opt/homebrew/Cellar/$name"; or test -e "/opt/homebrew/Caskroom/$name"
            set -ga __brew_packages_present "$name"
        else
            set -ga __brew_packages_missing "$name"
        end
    end

    if test (count $__brew_packages_missing) -eq 0
        return 0
    else
        return 1
    end
end

function __brew_install
    set -f packages $argv

    if __brew_packages_install_query $packages
        __msg --noop "packages already installed"
        return 0
    end

    if test (count $__pacman_packages_present) -gt 0
        __msg --noop "packages already installed: $__brew_packages_present"
    end
    __msg --eval "brew install $__brew_packages_missing"
end

function __brew_install_cask
    set -f packages $argv

    if __brew_packages_install_query $packages
        __msg --noop "casks already installed"
        return 0
    end

    if test (count $__pacman_packages_present) -gt 0
        __msg --noop "casks already installed: $__brew_packages_present"
    end
    __msg --eval "brew install --cask $__brew_packages_missing"
end
