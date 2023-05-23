
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
    echo "Usage: ./pushNspImage.sh [-t TAG]"
    echo "Build docker image from the code."
    echo " -t, --tag TAG: tag of an image to push (prod, test or dev, default: prod)"
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

docker push karolchlasta/genesis-sim:${tag}

