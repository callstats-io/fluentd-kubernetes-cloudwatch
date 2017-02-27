#!/bin/bash

# Usage:
#   ./Display.sh
#   ./Display.sh -o yaml

: ${APP_NAME:=fluentd-cloudwatch}
: ${NAMESPACE:=kube-system}

kubectl get secret,configmap,daemonset,pod --selector=app=$APP_NAME --namespace=$NAMESPACE $@
