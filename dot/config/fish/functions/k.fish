function k
    if test -n "$IDTE_KUBE_PRE_CMD"
        set -l old_dir (pwd)
        echo $IDTE_KUBE_PRE_CMD | source
        cd $old_dir
    end

    if test -n "$KUBECTL_NAMESPACE"
        kubectl --namespace $KUBECTL_NAMESPACE $argv
    else
        kubectl $argv
    end
end
