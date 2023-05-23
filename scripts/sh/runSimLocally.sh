# Set default values for parameters
container=`docker ps -l -q --filter name=nsp_genesis`
filePath="../../nsp-queues/localNspQueue.nsp"
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
    -f|--file)
    filePath="$2"
    shift # past argument
    shift # past value
    ;;
    -h|--help)
    echo "Usage: ./runSimLocally.sh [-c CONTAINER_NAME] [-f FILE_PATH] COMMAND"
    echo "Build docker image from the code."
    echo " -c, --container CONTAINER_NAME: name of the container on wich to start unit test default latest container"
    echo " -f, --file FILE_PATH: Path to file with experiments commands(default ../../nsp-queues/localNspQueue.nsp)"
    echo " -h, --help: show this help message"
    exit 0
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done

# Use parameters in script
echo "container name: $container"
echo "filePath: $filePath"

if [ -v filePath ]
then
# run experiments from file
  docker cp $filePath  $container:/usr/local/nsp-server/localSimulationQueue.nsp
  docker exec $container bash -c ' /usr/local/nsp-server/src/sh/runSimLocally.sh'

else
# run single simulation
  docker exec $container bash -c '  /usr/local/nsp-server/src/sh/runSim.sh --simulator genesis --modelName RetNet40 --simSuffix HPI-Docker-small-test  --simDesc RetNet40 --simTimeStepInSec 0.00005 --simTime 1 --columnDepth 3 --synapticProbability 0.1 --retX 5 --retY 8 --parallelMode 0 --numNodes 1 --modelInput 0 '
fi
