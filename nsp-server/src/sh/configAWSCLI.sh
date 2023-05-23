#!/bin/bash

aws configure set aws_access_key_id $nsp_aws_access_key_id
aws configure set aws_secret_access_key  $nsp_aws_secret_access_key
aws configure set region $nsp_region

if [ -n "$1" ]; then
    aws configure set aws_access_key_id $1
    aws configure set aws_secret_access_key  $2
    aws configure set aws_session_token $3
fi


aws configure set output json
export AWS_DEFAULT_OUTPUT="json"