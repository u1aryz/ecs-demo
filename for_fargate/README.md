# Dockerイメージの作成とプッシュ
ECSのタスクで使用するイメージをECRにプッシュする手順。

## Dependencies
- docker
- aws-cli
- ecs-cli

## 準備
.envを用意する。
```
PROXY_REPO=YOUR_PROXY_REPO
API_REPO=YOUR_API_REPO
```

## イメージ作成 & プッシュ
```
$ bash push_ecr.sh
```
