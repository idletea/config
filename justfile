default:
    #!/usr/bin/env fish
    if test (uname) = "Linux"
        exec just elk
    else
        exec just donkey
    end

#########
## elk ##
#########

elk: sys-config link-config packages user-units gpg-dir

sys-config:
    #!/usr/bin/fish
    source lib.fish
    __msg --heading system config
    __sys_file \
        elk/sys/iptables.conf \
        /etc/modules-load.d/iptables.conf
    __sys_file \
        elk/sys/bash.bashrc \
        /etc/bash.bashrc
    __sys_file \
        elk/sys/xdg.sh \
        /etc/profile.d/xdg.sh
    __sys_file \
        elk/sys/pacman.conf \
        /etc/pacman.conf

not-root:
    #!/usr/bin/fish
    source lib.fish
    if test (whoami) = "root"
        __msg --error "run me as a regular user"
        exit 1
    end

link-config: not-root
    #!/usr/bin/fish
    source lib.fish
    __msg --heading config files
    __link_recursive "common/home"
    __link_recursive "elk/home"

packages:
    #!/usr/bin/fish
    source lib.fish
    __msg --heading packages

    set base \
    	base-devel man-db openssh bind lsof \
        bash-completion unzip acpi btrfs-progs
    set utils \
        neovim ripgrep jq fzf fd git git-delta \
        procs podman brightnessctl rustup
    set fonts \
        noto-fonts noto-fonts-emoji noto-fonts-extra \
        ttf-iosevkaterm-nerd ttf-nerd-fonts-symbols-mono \
        ttf-liberation otf-font-awesome ttf-lilex-nerd
    set audio \
        pipewire-pulse pavucontrol
    set de \
        sway foot foot-terminfo xdg-desktop-portal waybar \
        xdg-desktop-portal-wlr wl-clipboard xorg-xwayland \
        mako
    set apps \
        firefox-developer-edition
    set aur \
        tofi

    __pacman_install \
        $base $utils $fonts $audio $de $apps
    __pacman_aur_install \
        $aur

    # install mise
    if not test -e $HOME/.local/bin/mise
        __msg --eval "curl https://mise.run | sh"
    else
        __msg --noop "mise already installed"
    end

user-units:
    #!/usr/bin/fish
    source lib.fish
    __msg --heading systemd units
    __systemd_user_enable "ssh-agent.service"

gpg-dir:
    #!/usr/bin/fish
    source lib.fish
    __msg --heading gpg dir
    if test -e $HOME/
        __msg --noop "already initialized"
    else
        __msg --eval "mkdir -p $HOME/.local/share/gnupg"
        __msg --eval "chmod 700 $HOME/.local/share/gnupg"
    end

############
## donkey ##
############

donkey: donkey-link-config donkey-brew-packages

donkey-link-config:
    #!/usr/bin/env fish
    source lib.fish
    __msg --heading config files
    __link_recursive "common/home"
    __link_recursive "donkey/home"

donkey-brew-packages:
    #!/usr/bin/env fish
    source lib.fish
    __msg --heading brew packages
    __brew_install \
        fish neovim fd bash-language-server yaml-language-server \
        fzf ripgrep git-delta coreutils
    __brew_install_cask \
        nikitabobko/tap/aerospace 1password-cli
