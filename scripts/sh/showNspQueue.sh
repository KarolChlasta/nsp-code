#!/bin/bash
# Show running and stopped NSP containers



# Set default values for parameters
local=1
remote=0
tmpFile="queue${PID}.tmp"
# Process command line arguments
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -l|--local)
      shift # past argument
    ;;
    -r|--remote)
    local=0
    remote=1
      shift # past argument
    ;;
    -c|--container)
    container="$2"
    shift # past argument
    shift # past value
    ;;

    -h|--help)
    echo "Usage: ./showNspQueue.sh  [-l] [-r] [-c CONTAINER_NAME]"
    echo "Show local NSP Queue on latest run container or remote NSP queue in AWS (default local)."
    echo " -c CONTAINER_NAME: specifies the name or ID of the container to be acted upon"
    echo " -h, --help: show this help message"
    exit 0
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done

echo "local: $local"
echo "remote: $remote"
echo "container: $container"

if [[ "$local" -eq 1 ]]; then
    if [  -n $container ]; then
     container=$(docker ps -l -q --filter name=nsp_genesis)
    fi
   echo "Container: $container"
   docker cp  ${container}:/usr/local/nsp-server/localSimulationQueue.nsp $tmpFile
else
   aws s3  cp  s3://nsp-project/requests/remoteSimulationQueue.nsp $tmpFile
fi
# if file exists
if test -f "$tmpFile"; then

  fs=`du -b $tmpFile| awk '{print $1}'`
  #echo $fs
  if [ $fs -lt 5 ]; then
    echo "empty simulation queue."
  else
    cat $tmpFile
  fi
  rm $tmpFile
else
 echo "Empty simulation queue."
fi
