# Fluentd image to send Kuberntes logs to CloudWatch

## Quickstart

1. Create AWS IAM user which has permission to store logs to CloudWatch

2. Clone this repository

3. You may want to edit the ConfigMap to change the region and log group name

4. Run:
```
echo -n "accesskeyhere" > aws_access_key
echo -n "secretkeyhere" > aws_secret_key
kubectl create secret --namespace=kube-system generic fluentd-secrets --from-file=aws_access_key --from-file=aws_secret_key
kubectl apply -f fluentd-cloudwatch-daemonset.yaml
```
