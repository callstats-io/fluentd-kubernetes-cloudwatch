# Fluentd image to send Kubernetes logs to CloudWatch

## Deployment

1. Create AWS IAM user which has permission to store logs to CloudWatch

2. Set environment variables for the AWS IAM user including region

```
export AWS_ACCESS_KEY_ID=<your key>
export AWS_SECRET_ACCESS_KEY=<your secret>
export AWS_DEFAULT_REGION=<your region>
```

3. Optionally set other environment variable to change resource names or labels

- `NAMESPACE` defaults to 'kube-system'
- `APP_NAME` defaults to 'fluentd-cloudwatch'
- `SECRET_NAME`,`CONFIG_NAME` default to `APP_NAME`
- `ENV_NAME` defaults to 'system'
- `CW_LOG_GROUP` defaults to 'kubernetes-cluster'

4. Run `Deploy.sh` to create the Secret, ConfigMap, and DaemonSet

5. Run `Display.sh` to check everything is running

## Removal

1. If you set custom values for the namespace or resource name environment variables, 
ensure they are still set to your values (`NAMESPACE`,`APP_NAME`,`SECRET_NAME`,`CONFIG_NAME`)

2. Run `Delete.sh`

3. Run `Display.sh` to check nothing is left
