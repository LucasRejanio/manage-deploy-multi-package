#!/usr/bin/env bash

# while getopts e:b:p:r: flag
# do
#     case "${flag}" in
#         e) ENVIRONMENT=${OPTARG};;
#         b) BUCKET=${OPTARG};;
#         p) PACKAGE=${OPTARG};;
#         r) REF=${OPTARG};;
#     esac
# done

echo "=== Starting script to trigger s3 deploy with github actions ==="

# Get token in the aws ssm to github authentication
# echo "Get Github API Token"
# TOKEN=$(aws --profile ci ssm get-parameters --region us-east-1 --names /github/api_token \
#         --with-decryption --query "Parameters[0].Value" | tr -d '"')

# Call actions to start deploy
echo "Send request to trigger action"
status_code=$(curl --write-out '%{http_code}' -u "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:" -X POST -H 'Accept: application/vnd.github.v3+json' \
https://api.github.com/repos/LucasRejanio/manage-deploy-multi-package/actions/workflows/deploys.yml/dispatches \
-d '{
    "ref":"main",
    "inputs":{
        "environment":"test"
    }
}')

if [[ "$status_code" == 204 ]] ; then
    echo "$status_code Successful request"
else
    echo "$status_code Bad request"
fi
