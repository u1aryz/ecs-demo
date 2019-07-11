# Fargate Provisioning
AWS Fargateの環境を提供する定義ファイル

## Dependencies
- [terraform (>= 0.12.0)](https://www.terraform.io/)

## 準備
terraform.tfvarsを用意する。
```
access_key="YOUR_AWS_ACCESS_KEY"
secret_key="YOUR_AWS_SECRET_KEY"
```

## 実行
```
$ terraform init
$ terraform plan
$ terraform apply
```

## 確認
```
$ terraform show
```

## 破棄
```
$ terraform destroy
```
