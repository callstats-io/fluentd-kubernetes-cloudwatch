#!/bin/bash
set -e

#
# Create Secret, ConfigMap, and DaemonSet for fluentd-cloudwatch
#

: ${AWS_ACCESS_KEY_ID?"Must define AWS_ACCESS_KEY_ID"}
: ${AWS_SECRET_ACCESS_KEY?"Must define AWS_SECRET_ACCESS_KEY"}
: ${AWS_DEFAULT_REGION?"Must define AWS_DEFAULT_REGION"}

: ${APP_NAME:=fluentd-cloudwatch}
: ${SECRET_NAME:=$APP_NAME}
: ${CONFIG_NAME:=$APP_NAME}
: ${ENV_NAME:=system}
: ${NAMESPACE:=kube-system}
: ${IMAGE_NAME:=callstats/fluentd-kubernetes-cloudwatch:v1.1.2}
: ${CW_LOG_GROUP:=kubernetes-cluster}

#
# Secret
#

if [[ "$(kubectl get secret $SECRET_NAME --namespace=$NAMESPACE --output name 2> /dev/null || true)" = "secret/${SECRET_NAME}" ]]; then
  ACTION=replace
else
  ACTION=create
fi

kubectl $ACTION -f - <<END
apiVersion: v1
kind: Secret
type: kubernetes.io/opaque
metadata:
  name: $SECRET_NAME
  namespace: $NAMESPACE
  labels:
    app: $APP_NAME
    env: $ENV_NAME
data:
  AWS_ACCESS_KEY_ID: $(echo -n "${AWS_ACCESS_KEY_ID}" | base64 -w 0)
  AWS_SECRET_ACCESS_KEY: $(echo -n "${AWS_SECRET_ACCESS_KEY}" | base64 -w 0)
END

#
# ConfigMap
#

kubectl apply -f - <<END
apiVersion: v1
kind: ConfigMap
metadata:
  name: $CONFIG_NAME
  namespace: $NAMESPACE
  labels:
    app: $APP_NAME
    env: $ENV_NAME
data:
  AWS_REGION: $AWS_DEFAULT_REGION
  CW_LOG_GROUP: $CW_LOG_GROUP
END

#
# DaemonSet
#

export APP_NAME ENV_NAME CONFIG_NAME SECRET_NAME NAMESPACE IMAGE_NAME
envsubst < fluentd-cloudwatch-daemonset-template.yaml | kubectl apply -f -
