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
curl -u "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:" -X POST -H 'Accept: application/vnd.github.v3+json' \
https://api.github.com/repos/enjoei/manage-deploy-multi-package/actions/workflows/deploys.yml/dispatches \
-d '{"ref":"main"}'
