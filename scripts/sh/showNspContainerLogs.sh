#!/bin/bash
# login to the latest NSP container

# Set default values for parameters
# container_name or container_id works the same hear
containerName=`docker ps -l -q --filter name=nsp_genesis`

# Process command line arguments
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -c|--container)
    containerName="$2"
    shift # past argument
    shift # past value
    ;;
    -h|--help)
    echo "Usage: ./showNspContainerLogs.sh [-c CONTAINER_NAME]"
    echo "Show console output of the latest container or the particular container."
    echo " -c, --container CONTAINER_NAME: container name or id to login"
    echo " -h, --help: show this help message"
    exit 0
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done

# Use parameters in script
echo "containerName: $containerName"

docker logs $containerName
