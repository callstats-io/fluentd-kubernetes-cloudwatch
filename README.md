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
- `APP_NAME`,`SECRET_NAME`,`CONFIG_NAME` default to 'fluentd-cloudwatch'
- `ENV_NAME` defaults to 'system'

4. Run `Deploy.sh` to create the Secret, ConfigMap, and DaemonSet

5. Run `Display.sh` to check everything is running
