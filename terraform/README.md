# Fargate Provisioning
AWS Fargateの環境を提供する定義ファイル

## Dependencies
- [terraform (>= 0.12.0)](https://www.terraform.io/)

## 準備
terraform.tfvarsを用意する。
```
access_key = "YOUR_AWS_ACCESS_KEY"
secret_key = "YOUR_AWS_SECRET_KEY"
```

## リポジトリを作成
ECRリポジトリを先に作成
```
$ terraform init # 初回のみ
$ terraform plan -target=aws_ecr_repository.proxy-repo -target=aws_ecr_repository.api-repo
$ terraform apply -target=aws_ecr_repository.proxy-repo -target=aws_ecr_repository.api-repo
```

## リポジトリにDockerイメージをpush
TODO

## リポジトリ以外の環境を作成
```
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
