set shell := ["fish", "-c"]

default:
    #!/usr/bin/env fish
    if test (uname) = "Linux"
        exec just corvus
    else
        exec just draught
    end


############
## corvus ##
############
corvus: pkgs-pacman sys-files link-home latest-mise \
    (systemd-user-enable "ssh-agent.service")

sys-files: (header "system files") \
    (sys-copy "corvus/sys/pacman.conf" "/etc/pacman.conf") \
    (sys-copy "corvus/sys/xdg.sh" "/etc/profile.d/xdg.sh") \
    (sys-copy "corvus/sys/bash.bashrc" "/etc/bash.bashrc")

link-home: (header "symlinks") \
    (link-recursive "common/home") \
    (link-recursive "corvus/home")

pkgs-pacman: (header "packages")
    #!/usr/bin/env fish
    set -l stdout (mktemp)
    set -l stderr (mktemp)
    sudo pacman -S --needed --noconfirm -q \
        base base-devel man-db neovim ripgrep openssh fzf \
        fd git git-delta bind lsof bash-completion unzip \
        jq imagemagick acpi btrfs-progs \
        \
        noto-fonts noto-fonts-emoji noto-fonts-extra \
        ttf-iosevkaterm-nerd ttf-nerd-fonts-symbols-mono \
        ttf-liberation otf-hermit-nerd otf-font-awesome \
        \
        sway swayidle swaylock swaybg foot foot-terminfo \
        waybar fuzzel brightnessctl xdg-user-dirs xdg-utils \
        xdg-desktop-portal xdg-desktop-portal-wlr libnotify mako \
        pipewire-pulse pavucontrol wl-clipboard xorg-xwayland \
        grim slurp \
        \
        podman \
        \
        >$stdout 2>$stderr
    if test "$status" != "0"
        just msg "-> pacman failed" "error"
        cat $stderr
    else if cat $stdout | grep "there is nothing to do" >/dev/null
        just msg "all packages installed" "noop"
    else
        cat $stdout
    end

latest-mise: (header "latest mise")
    #!/usr/bin/fish
    set -l tmpdir (mktemp --directory)
    set -l json (curl -L --silent \
        -H "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        "https://api.github.com/repos/jdx/mise/releases?per_page=1")
    set -l tag_name (echo $json | jq ".[0].tag_name" | sed 's/"//g')
    set -l sums_url (echo $json | jq '.[0].assets.[]' \
        | jq 'select(.name == "SHASUMS256.txt").browser_download_url' | sed 's/"//g')
    set -l bin_name "mise-$tag_name-linux-x64"
    set -l bin_url (echo $json | jq '.[0].assets.[]' \
        | jq "select(.name == \"$bin_name\").browser_download_url" | sed 's/"//g')
    # check if we have latest already
    curl --silent -L "$sums_url" -o $tmpdir/shasums256
    set -l expect_sum (cat $tmpdir/shasums256 \
       | grep "linux-x64" | grep -v "musl" | grep -v ".tar" | awk '{print $1}')
    set -l actual_sum (sha256sum ~/.local/bin/mise 2>/dev/null | awk '{print $1}')
    if test "$status" != 0; or test "$expect_sum" != "$actual_sum"
        mkdir -p ~/.local/bin
        curl -L --silent $bin_url -o ~/.local/bin/mise
        chmod a+x ~/.local/bin/mise
       just msg "mise $tag_name installed to ~/.local/bin/mise"
    else
       just msg "/home/terry/.local/bin/mise already latest" "noop"
    end
    rm -rf $tmpdir

systemd-user-enable service: (header "systemd user units")
    #!/usr/bin/env fish
    if not test -e ~/.config/systemd/user/default.target.wants/{{service}}
        just cmd "systemctl --user enable --now ssh-agent.service"
    else
        just msg "already enabled" "noop"
    end

#############
## draught ##
#############
draught: draught-link-home

draught-link-home: (header "symlinks") \
    (link-recursive "common/home") \
    (link-recursive "draught/home")

###############
## utilities ##
###############
link-recursive target_dir:
    #!/usr/bin/env fish
    for path in (fd --hidden . "{{target_dir}}")
        set -l relpath (string replace --regex "^{{target_dir}}\/?" "" "$path")
        set -l linkpath (echo "$HOME"/$relpath)
    	set -l fullpath (realpath $path)
        if test -d $fullpath
            if not test -e $linkpath
                just cmd "mkdir -p $linkpath"
            else if not test -d $linkpath
                just msg "$linkpath is not a directory" "error"
            end
        else
            if test -h $linkpath
                # TODO: check it's the *right* link
                just msg "$linkpath already symlinked" "noop"
            else
                just cmd "ln -s $fullpath $linkpath"
            end
        end
    end

sys-copy source dest chown="root:root":
    #!/usr/bin/env fish
    if sudo test -e "{{dest}}"
        set -l expect (sudo md5sum {{source}} | awk '{print $1}')
        set -l actual (sudo md5sum {{dest}} | awk '{print $1}')
        if test "$expect" = "$actual"
            just msg "{{dest}} already present" "noop"
        else
            just msg "{{dest}} exists in wrong state" "error"
        end
    else
        just cmd "sudo cp {{source}} {{dest}}; and sudo chown {{chown}} {{dest}}"
    end

## aesthetics
header name:
    @printf "%s=== {{name}}%s\n" \
        (set_color -o cyan) (set_color normal)
cmd cmd:
    @just msg "{{cmd}}" "bold" "true"
msg msg style="bold" eval="false":
    #!/usr/bin/env fish
    if test "{{style}}" = "bold"
        printf "%s{{msg}}%s\n" \
            (set_color -o white) (set_color normal)
    else if test "{{style}}" = "noop"
        printf "%s{{msg}}%s\n" \
            (set_color -d white) (set_color normal)
    else if test "{{style}}" = "warning"
        printf "%s{{msg}}%s\n" \
            (set_color -o yellow) (set_color normal)
    else
        printf "%s{{msg}}%s\n" \
            (set_color -o red) (set_color normal)
    end
    if not test "{{eval}}" = "false"
        eval "{{msg}}"
    end
