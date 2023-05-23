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
    echo "Usage: ./loginNspContainer.sh [-c CONTAINER_NAME]"
    echo "login to latest container or to particular container."
    echo " -c, --container CONTAINER_NAME: container name to login"
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

docker exec -it $containerName bash
