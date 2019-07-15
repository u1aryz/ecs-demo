#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

if [ ! -f $SCRIPT_DIR/.env ]; then
  echo ".envがありません"
  exit 1
fi

export $(grep -v '^#' .env | xargs)

if [ -z $PROXY_REPO -o -z $API_REPO ]; then
  echo ".envの内容を確認してください"
  exit 1
fi

docker-compose -f $SCRIPT_DIR/docker-compose.yml build

$(aws ecr get-login --no-include-email --region us-east-1)
ecs-cli push $PROXY_REPO:latest
ecs-cli push $API_REPO:latest
