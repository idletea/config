function platform_config
    set -ax PATH /opt/homebrew/bin
    set -ax PATH /Users/tkerr/.local/bin
    set -ax PATH /Users/tkerr/.local/share/cargo/bin

    set -gx HOMEBREW_NO_AUTO_UPDATE 1

    set -l gcs_inc "/opt/homebrew/share/google-cloud-sdk/path.fish.inc"
    if test -e "$gcs_inc"; source "$gcs_inc"; end

    fish_add_path --prepend /Users/tkerr/Downloads/nvim-macos-arm64/bin

    if command -v rustup &>/dev/null
        fish_add_path --prepend (brew --prefix rustup)/bin
    end

    alias ls "gls --color=auto \
        --hide=Applications \
        --hide=Desktop \
        --hide=Downloads \
        --hide=Movies \
        --hide=Pictures \
        --hide=Documents \
        --hide=Library \
        --hide=Music \
        --hide=Public"
end
