
#!/bin/bash
# script that stop NSP container


 
# Set default values for parameters

# Process command line arguments
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
   -h|--help)
    echo "Usage: ./deleteNspImages.sh "
    echo "Delete all NSP images"
    echo " -h, --help: show this help message"
    exit 0
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done

# Use parameters in script


docker images --filter reference='karolchlasta/genesis-sim' -q | docker rmi -f
