
#!/bin/bash
# Show running and stopped NSP containers


 
# Set default values for parameters

# Process command line arguments
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    echo "Usage: ./showNspContainers.sh"
    echo "Show running and stopped NSP containers."
    echo " -h, --help: show this help message"
    exit 0
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done

# Use parameters in script
echo "Running containers:"
docker ps --filter name=nsp_genesis
echo "Stopped containers:"
docker ps -a --filter name=nsp_genesis 