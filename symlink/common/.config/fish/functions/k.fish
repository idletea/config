function k
    if test -f ~/.config/kube/kuberc
        set -la args "--kuberc ~/.config/kube/kuberc"
    end
    kubectl $argv $args
end
