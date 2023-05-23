#!/bin/bash
# upload models to s3 from the current folder
# go to the nsp-model repository
# execute the command
aws s3 cp . s3://nsp-project/models/genesis --recursive --exclude "*.md" --exclude ".*"


























