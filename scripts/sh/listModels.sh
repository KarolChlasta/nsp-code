#!/bin/bash
# show list of mod from s3

 
# Set default values for parameters
container=`docker ps -l -q --filter name=nsp_genesis`

# Process command line arguments
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -c|--container)
    container="$2"
    shift # past argument
    shift # past value
    ;;
    -h|--help)
    echo "Usage: ./listModels.sh [-c CONTAINER_NAME]"
    echo "Show models from S3."
    echo " -c, --container CONTAINER_NAME: name of the container on wich to show Models (default latest container)"
    echo " -h, --help: show this help message"
    exit 0
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done

# Use parameters in script
echo "container : $container"

docker exec $container bash -c '  /usr/local/nsp-server/src/sh/listModels.sh '
 