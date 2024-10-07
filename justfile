export LUA_PATH := `pwd` + "/lib/?.lua;;"

default:
    #!/bin/sh
    if [ "$(uname)" = "Linux" ]; then
        exec just linux
    else
        exec just macos
    fi

###########
## linux ##
###########
linux: sys-config packages services home-dirs mise link-config

sys-config:
    #!/usr/bin/lua
    local log, fs = require("config.log"), require("config.fs")
    log.section "system config"
    fs.sys_file {
        src = "linux/sys/pacman.conf",
        dst = "/etc/pacman.conf" }
    fs.sys_file {
        src = "linux/sys/bash.bashrc",
        dst = "/etc/bash.bashrc" }
    fs.sys_file {
        src = "linux/sys/xdg.sh",
        dst = "/etc/profile.d/xdg.sh" }

packages:
    #!/usr/bin/lua
    local log, pacman = require("config.log"), require("config.pacman")
    log.section "packages"
    pacman.install {
        -- base
        "base-devel", "man-db", "openssh", "acpi", "bash-completion", "fish", "unzip",
        -- utils
        "bind", "neovim", "ripgrep", "jq", "fzf", "fd", "git", "git-delta", "lazygit",
        "procs", "podman", "brightnessctl", "ipcalc", "python", "python-pipx",
        -- fonts
        "ttf-liberation", "otf-font-awesome", "noto-fonts", "noto-fonts-emoji",
        "noto-fonts-extra", "noto-fonts-cjk", "ttf-iosevka-nerd",
        -- audio
        "pipewire-pulse", "pavucontrol",
        -- bluetooth
        "bluez", "bluez-utils", "blueberry",
        -- desktop
        "sway", "swaybg", "kitty", "kitty-terminfo", "waybar", "xorg-xwayland",
        "xdg-desktop-portal-wlr", "xdg-desktop-portal-gtk", "wofi", "wl-clipboard",
        -- apps
        "firefox-developer-edition" }

services:
    #!/usr/bin/lua
    local log, systemd = require("config.log"), require("config.systemd")
    log.section "services"
    systemd.enable "bluetooth.service"
    systemd.user_enable "ssh-agent.service"
    systemd.user_enable "pipewire-pulse.service"

home-dirs:
    #!/usr/bin/lua
    local log, fs = require("config.log"), require("config.fs")
    local home_env = assert(os.getenv("HOME"))
    local home = function(dir) return home_env .. "/" .. dir end
    log.section "home dirs"
    for _, dir in ipairs{"downloads", "documents", "images", ".local/bin"} do
        fs.dir(home(dir))
    end
    if fs.dir(home(".local/share/gnupg")) then
        log.exec("chmod 700 ~/.local/share/gnupg")
    end

mise:
    #!/usr/bin/lua
    local log, lfs = require("config.log"), require("lfs")
    local mise_path = assert(os.getenv("HOME")) .. "/.local/bin/mise"
    log.section "mise"
    if lfs.attributes(mise_path) == nil then
        log.exec "curl https://mise.run | sh"
    else
        log.no_op "mise already installed"
    end

link-config:
    #!/usr/bin/lua
    local log, fs = require("config.log"), require("config.fs")
    log.section "link configs"
    fs.recursive "common/home"
    fs.recursive "linux/home"

###########
## macos ##
###########
macos: macos-brew macos-link-config

macos-brew:
    #!/usr/bin/env lua
    local log, brew = require("config.log"), require("config.brew")
    log.section "brew packages"
    brew.install {
        "fish", "neovim", "fd", "bash-language-server", "yaml-language-server",
        "fzf", "ripgrep", "git-delta", "coreutils", "ipcalc", "procs", "hyperfine",
    }
    brew.install_casks {
        "aerospace", "1password-cli", "font-blex-mono-nerd-font",
        "font-iosevka-term-nerd-font",
    }

macos-link-config:
    #!/usr/bin/env lua
    local log, fs = require("config.log"), require("config.fs")
    log.section "link configs"
    fs.recursive "common/home"
    fs.recursive "macos/home"
