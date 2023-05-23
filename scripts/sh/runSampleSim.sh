
 
# Set default values for parameters
container=`docker ps -l -q --filter name=nsp_genesis`

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
    -h|--help)
    echo "Usage: ./runSampleSim.sh [-c CONTAINER_NAME]"
    echo "Build docker image from the code."
    echo " -c, --container CONTAINER_NAME: name of the container on wich to start sample experiments (default latest NSP container)"
    echo " -h, --help: show this help message"
    exit 0
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done

# Use parameters in script
echo "NSP container: $container"

 docker exec $container bash -c '  /usr/local/nsp-server/src/sh/runSim.sh --simulator genesis --modelName RetNet40 --simSuffix Docker-sample-1  --simDesc RetNet40 --simTimeStepInSec 0.00005 --simTime 1 --columnDepth 25 --synapticProbability 0.1 --retX 5 --retY 8 --parallelMode 0 --numNodes 1 --modelInput 0 ' | tee sampleExp1.log

 docker exec $container bash -c '  /usr/local/nsp-server/src/sh/runSim.sh --simulator genesis --modelName RetNet40 --simSuffix Docker-sample-2  --simDesc RetNet40 --simTimeStepInSec 0.00005 --simTime 1 --columnDepth 25 --synapticProbability 0.1 --retX 5 --retY 8 --parallelMode 0 --numNodes 1 --modelInput A ' | tee sampleExp2.log
 
 docker exec $container bash -c '  /usr/local/nsp-server/src/sh/runSim.sh --simulator genesis --modelName RetNet40 --simSuffix Docker-sample-3  --simDesc RetNet40 --simTimeStepInSec 0.00005 --simTime 1 --columnDepth 25 --synapticProbability 0.1 --retX 5 --retY 8 --parallelMode 0 --numNodes 1 --modelInput 1 ' | tee sampleExp3.log
 
s3uri=`tail -n 1 sampleExp1.log`
./downloadSim.sh --uri $s3uri
s3uri=`tail -n 1 sampleExp2.log`
./downloadSim.sh --uri $s3uri
s3uri=`tail -n 1 sampleExp3.log`
./downloadSim.sh --uri $s3uri