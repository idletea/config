set shell := ["fish", "-c"]
get-latest := "false"

default: packages system-config config-files latest-releases

## packages
packages: (header "packages")
    #!/usr/bin/fish
    set -l stdout (mktemp)
    set -l stderr (mktemp)
    sudo pacman -S --needed --noconfirm -q \
        base base-devel man-db neovim ripgrep openssh fzf fd git \
        git-delta bash-completion bind unzip lsof jq imagemagick \
        acpi watchexec \
        \
        ttf-iosevkaterm-nerd ttf-nerd-fonts-symbols-mono \
        ttf-liberation otf-font-awesome \
        \
        sway swayidle swaylock swaybg foot foot-terminfo \
        waybar fuzzel brightnessctl xdg-user-dirs xdg-utils \
        xdg-desktop-portal xdg-desktop-portal-wlr \
        pipewire-pulse pavucontrol wl-clipboard xorg-xwayland \
        \
        podman kubectl \
        >$stdout 2>$stderr
    if test "$status" != "0"
        just msg "pacman failure!" "error"
        cat $stderr
    else if cat $stdout | grep "there is nothing to do" >/dev/null
        just msg "all packages installed" "noop"
    else
        cat $stdout
    end

## system config
system-config: (header "system config") pacman-conf profile-xdg bash-bashrc
pacman-conf: (system-copy "pacman.conf" "/etc/pacman.conf")
profile-xdg: (system-copy "xdg.sh" "/etc/profile.d/xdg.sh")
bash-bashrc: (system-copy "bash.bashrc" "/etc/bash.bashrc")
system-copy name dest:
    #!/usr/bin/fish
    if sudo test -e "{{dest}}"
        set -l expect (sudo md5sum sys/{{name}} | awk '{print $1}')
        set -l actual (sudo md5sum {{dest}} | awk '{print $1}')
        if test "$expect" = "$actual"
            just msg "{{name}} already present" "noop"
        else
            just msg "{{dest}} exists in wrong state" "error"
        end
    else
        just cmd "sudo cp sys/{{name}} {{dest}}; and sudo chown root:root {{dest}}"
    end

## config files
config-files: (header "config files") dot-home dot-config dot-local
dot-home:
    #!/usr/bin/fish
    for file in (ls dot)
        if not test -d dot/$file
            set -l fullpath (realpath dot/$file)
            set -l target (echo "$HOME/.$file")
            if test -h $target
                just msg "$target already symlinked" "noop"
            else
                just cmd "ln -s $fullpath $target"
            end
        end
    end
dot-config:
    #!/usr/bin/fish
    # tail -n +2 skips the first line (.config itself)
    for path in (find dot/config | tail -n +2)
    	set -l fullpath (realpath $path)
    	set -l target (echo "$HOME/.config$path" | sed "s/dot\/config//")
        if test -d $fullpath
            if not test -e $target
                just cmd "mkdir -p $target"
            else if not test -d $target
                just msg "not a directory: $target" "error"
            end
        else
            if test -h $target
                just msg "$target already symlinked" "noop"
            else
                just cmd "ln -s $fullpath $target"
            end
        end
    end
dot-local:
    #!/usr/bin/fish
    # tail -n +2 skips the first line (.config itself)
    for path in (find dot/local | tail -n +2)
    	set -l fullpath (realpath $path)
    	set -l target (echo "$HOME/.local$path" | sed "s/dot\/local//")
        if test -d $fullpath
            if not test -e $target
                just cmd "mkdir -p $target"
            else if not test -d $target
                just msg "not a directory: $target" "error"
            end
        else
            if test -h $target
                just msg "$target already symlinked" "noop"
            else
                just cmd "ln -s $fullpath $target"
            end
        end
    end

## latest releases
latest-releases: (header "latest releases") latest-mise
latest-mise:
    #!/usr/bin/fish
    if test "{{get-latest}}" = "false"
        just msg "run with `--set get-latest true` to run" "warning"
        exit 0
    end
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

## util
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
