[[ $- != *i* ]] && return
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# config
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible.cfg"
export ANSIBLE_HOME="${XDG_CONFIG_HOME}/ansible"
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"
export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"
export BASH_COMPLETION_USER_FILE="${XDG_CONFIG_HOME}/bash-completion/bash_completion"
export BUNDLE_USER_CONFIG="${XDG_CONFIG_HOME}/bundle"
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export FFMPEG_DATADIR="${XDG_CONFIG_HOME}/ffmpeg"
export KUBECONFIG="${XDG_CONFIG_HOME}/kube"

# cache
export ANSIBLE_GALAXY_CACHE_DIR="${XDG_CACHE_HOME}/ansible/galaxy_cache"
export BUNDLE_USER_CACHE="${XDG_CACHE_HOME}/bundle"
export DENO_DIR="${XDG_CACHE_HOME}/deno"
export HISTFILE="${XDG_CACHE_HOME}/hist"
export KUBECACHEDIR="${XDG_CACHE_HOME}/kube"
export LESSHISTFILE="${XDG_CACHE_HOME}/lesshist"
export MYPY_CACHE_DIR="${XDG_CACHE_HOME}/mypy"
export NODE_REPL_HISTORY="${XDG_CACHE_HOME}/node_hst"
export RUFF_CACHE_DIR="${XDG_CACHE_HOME}/ruff"

# data
export BUNDLE_USER_PLUGIN="${XDG_DATA_HOME}/bundle"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export DENO_INSTALL_ROOT="${XDG_DATA_HOME}/deno"
export MINIKUBE_HOME="${XDG_DATA_HOME}/minikube"
export NODE_REPL_HISTORY="${XDG_DATA_HOME}/node_repl_history"
export PULUMI_HOME="${XDG_DATA_HOME}/pulumi"
export RBENV_ROOT="${XDG_DATA_HOME}/rbenv"
export RLWRAP_HOME="${XDG_DATA_HOME}/rlwrap"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
export PYTHON_HISTORY="${XDG_DATA_HOME}/python_history"
[ ! "$NOFISH" ] && exec /opt/homebrew/bin/fish
