# Fluentd image to send Kubernetes logs to CloudWatch


## Requirements

* envsubst: this is part of `gettext` package. If you're on macOS and using `brew`, you will have to force link `brew link --force gettext`

## Deployment

1. Create AWS IAM user which has permission to store logs to CloudWatch

2. Optionally set environment variable to change the default resource names and labels

- `NAMESPACE` defaults to 'kube-system'
- `APP_NAME` defaults to 'fluentd-cloudwatch'
- `SECRET_NAME`,`CONFIG_NAME` default to `APP_NAME`
- `ENV_NAME` defaults to 'system'
- `CW_LOG_GROUP` defaults to 'kubernetes-cluster'

3. Set environment variables for the AWS IAM user and CloudWatch region or set them just when running `deploy.sh` in the next step
```
export LOGGING_AWS_ACCESS_KEY_ID=<your key>
export LOGGING_AWS_SECRET_ACCESS_KEY=<your secret>
export LOGGING_AWS_REGION=<your region>
```

4. Run `deploy.sh` to create the Secret, ConfigMap, and DaemonSet, setting the AWS IAM user and CloudWatch region environments variables if you did not export them in the previous step.
```
LOGGING_AWS_ACCESS_KEY_ID=<your key> LOGGING_AWS_SECRET_ACCESS_KEY=<your secret> LOGGING_AWS_REGION=<your region> ./deploy.sh
```

5. Run `display.sh` to check everything is running

## Removal

1. If you set custom values for the namespace or resource name environment variables,
ensure they are still set to your values (`NAMESPACE`,`APP_NAME`,`SECRET_NAME`,`CONFIG_NAME`)

2. Run `delete.sh`

3. Run `display.sh` to check nothing is left
