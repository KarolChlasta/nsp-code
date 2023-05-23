#!/bin/bash
# script that start NSP container

# Set default values for parameters
tag=prod
containerName='nsp_genesis'
envFile='../../config.nsp'

# Process command line arguments
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -t|--tag)
    tag="$2"
    shift # past argument
    shift # past value
    ;;
    -u|--unique)
    containerName=$containerName"_$$"
    shift # past argument
    shift # past value
    ;;
    -e|--env-file)
    envFile="$2"
    shift # past argument
    shift # past value
    ;;
    -h|--help)
    echo "Usage: ./startNspContainer.sh [-t TAG]"
    echo "create new container from the image based on tag."
    echo " -t, --tag TAG: tag of an image to run (prod, test or dev, default: prod)"
    echo " -u, --unique: option to generate unique container name"
    echo " -e, --env-file: environment file location"
    echo " -h, --help: show this help message"
    exit 0
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done

# Use parameters in script
echo "tag: $tag"
echo "containerName: $containerName"
echo "envFile: $envFile"

docker run --env-file $envFile  --name $containerName  -it karolchlasta/genesis-sim:${tag}
