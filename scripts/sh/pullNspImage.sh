
#!/bin/bash
# script that pull image with the tag from parameters to remote docker repository

# Set default values for parameters
tag=prod

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
    -h|--help)
    echo "Usage: ./pullNspImage.sh [-t TAG]"
    echo "Pull docker image from the Docker repository.."
    echo " -t, --tag TAG: tag of an image to download (prod, test or dev, default: prod)"
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

docker pull karolchlasta/genesis-sim:${tag}

