function k
    if test -n "$KUBECTL_NAMESPACE"
        kubectl --namespace $KUBECTL_NAMESPACE $argv
    else
        kubectl $argv
    end
end
