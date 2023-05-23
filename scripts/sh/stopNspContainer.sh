
#!/bin/bash
# script that stop NSP container


 
# Set default values for parameters
containerName=`docker ps -l -q --filter name=nsp_genesis `

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
    echo "Usage: ./runUnitTest.sh [-c CONTAINER_NAME]"
    echo "Stop and delete NSP container."
    echo " -c, --container CONTAINER_NAME: name of the container on wich to start unit test default latest container"
    echo " -h, --help: show this help message"
    exit 0
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done

# Use parameters in script
echo "container name: $containerName"


docker stop $containerName
docker rm  $containerName
echo "NSP container $containerName was deleted."