function platform_config
    set -ax PATH /opt/homebrew/bin
    set -ax PATH /Users/tkerr/.local/bin
    set -ax PATH /Users/tkerr/.local/share/cargo/bin

    set -gx HOMEBREW_NO_AUTO_UPDATE 1

    set -l gcs_inc "/opt/homebrew/share/google-cloud-sdk/path.fish.inc"
    if test -e "$gcs_inc"; source "$gcs_inc"; end

    set -l devex_inc "$HOME/repos/devex/shellenv.fish"
    if test -e "$devex_inc"; source "$devex_inc"; end

    alias ls "gls --color=auto \
        --hide=Desktop \
        --hide=Downloads \
        --hide=Movies \
        --hide=Pictures \
        --hide=Documents \
        --hide=Library \
        --hide=Music \
        --hide=Public"
end
