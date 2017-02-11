#!/bin/bash
set -e

#
# Delete Secret, ConfigMap, and DaemonSet for fluentd-cloudwatch
#

: ${APP_NAME:=fluentd-cloudwatch}
: ${SECRET_NAME:=$APP_NAME}
: ${CONFIG_NAME:=$APP_NAME}
: ${NAMESPACE:=kube-system}

kubectl delete secret $SECRET_NAME --namespace=$NAMESPACE
kubectl delete configmap $CONFIG_NAME --namespace=$NAMESPACE
kubectl delete daemonset $APP_NAME --namespace=$NAMESPACE
