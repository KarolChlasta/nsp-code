#!/bin/bash
# download modelName files from s3 do folder nspModelsPath
# params:
#    modelName
#    nspModelsPath 
# example
# downloadModelFromS3 s3://nsp-project/models/genesis/ 

modelName=$1
nspModelsPath=$2
aws s3 sync  s3://nsp-project/models/genesis/${modelName} $nspModelsPath

