#!/bin/bash
# show list of experiments from s3

 
# Set default values for parameters
container=`docker ps -l -q --filter name=nsp_genesis`
n=10
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
    -n)
    n="$2"
    shift # past argument
    shift # past value
    -h|--help)
    echo "Usage: ./listSim.sh [-n NUM]"
    echo "Show Experiments from S3."
    echo " -c, --container CONTAINER_NAME: name of the container on wich to show experiments (default latest container)"
    echo " -n NUM: Output the last NUM experiments, instead of the last 10"
    echo " -h, --help: show this help message"
    exit 0
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done

docker exec $container bash -c " /usr/local/nsp-server/src/sh/listSim.sh -n $n"