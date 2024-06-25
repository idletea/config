# this is just stuff I set in /etc/profile.d on linux
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_CACHE_HOME "$HOME/.cache"
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_STATE_HOME "$HOME/.local/state"

# config
set -x ANSIBLE_CONFIG "$XDG_CONFIG_HOME/ansible.cfg"
set -x ANSIBLE_HOME "$XDG_CONFIG_HOME/ansible"
set -x AWS_CONFIG_FILE "$XDG_CONFIG_HOME/aws/config"
set -x AWS_SHARED_CREDENTIALS_FILE "$XDG_CONFIG_HOME/aws/credentials"
set -x BASH_COMPLETION_USER_FILE "$XDG_CONFIG_HOME/bash-completion/bash_completion"
set -x BUNDLE_USER_CONFIG "$XDG_CONFIG_HOME/bundle"
set -x DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -x FFMPEG_DATADIR "$XDG_CONFIG_HOME/ffmpeg"
set -x KUBECONFIG "$XDG_CONFIG_HOME/kube"

# cache
set -x ANSIBLE_GALAXY_CACHE_DIR "$XDG_CACHE_HOME/ansible/galaxy_cache"
set -x BUNDLE_USER_CACHE "$XDG_CACHE_HOME/bundle"
set -x DENO_DIR "$XDG_CACHE_HOME/deno"
set -x HISTFILE "$XDG_CACHE_HOME/hist"
set -x KUBECACHEDIR "$XDG_CACHE_HOME/kube"
set -x LESSHISTFILE "$XDG_CACHE_HOME/lesshist"
set -x MYPY_CACHE_DIR "$XDG_CACHE_HOME/mypy"
set -x NODE_REPL_HISTORY "$XDG_CACHE_HOME/node_hst"
set -x RUFF_CACHE_DIR "$XDG_CACHE_HOME/ruff"

# data
set -x BUNDLE_USER_PLUGIN "$XDG_DATA_HOME/bundle"
set -x CARGO_HOME "$XDG_DATA_HOME/cargo"
set -x DENO_INSTALL_ROOT "$XDG_DATA_HOME/deno"
set -x MINIKUBE_HOME "$XDG_DATA_HOME/minikube"
set -x NODE_REPL_HISTORY "$XDG_DATA_HOME/node_repl_history"
set -x PULUMI_HOME "$XDG_DATA_HOME/pulumi"
set -x RBENV_ROOT "$XDG_DATA_HOME/rbenv"
set -x RLWRAP_HOME "$XDG_DATA_HOME/rlwrap"
set -x RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -x PYTHON_HISTORY "$XDG_DATA_HOME/python_history"
