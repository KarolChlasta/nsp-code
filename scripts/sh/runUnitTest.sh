
 
# Set default values for parameters
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
    echo "Usage: ./runUnitTest.sh [-c CONTAINER_NAME]"
    echo "Build docker image from the code."
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

 docker exec $containerName bash -c '  /usr/local/nsp-server/src/sh/runSim.sh --simulator genesis --modelName RetNet40 --simSuffix Docker-small-test  --simDesc RetNet40 --simTimeStepInSec 0.00005 --simTime 1 --columnDepth 3 --synapticProbability 0.1 --retX 5 --retY 8 --parallelMode 0 --numNodes 1 --modelInput 0 ' | tee test1.log
 s3uri=`tail -n 1 test1.log`
 #./runUnitTestCheck.sh RetNet40 0 $s3uri
 docker exec $containerName bash -c "/usr/local/nsp-server/script/sh/runUnitTestCheck.sh -m RetNet40 -p 0 -u $s3uri"

 docker exec $containerName bash -c '  /usr/local/nsp-server/src/sh/runSim.sh --simulator genesis --modelName RetNet40 --simSuffix Docker-small-test  --simDesc RetNet40 --simTimeStepInSec 0.00005 --simTime 1 --columnDepth 3 --synapticProbability 0.1 --retX 5 --retY 8 --parallelMode 0 --numNodes 1 --modelInput A ' | tee test2.log
 s3uri=`tail -n 1 test2.log`
 docker exec $containerName bash -c "/usr/local/nsp-server/script/sh/runUnitTestCheck.sh -m RetNet40 -p 12 -u $s3uri"

 docker exec $containerName bash -c '  /usr/local/nsp-server/src/sh/runSim.sh --simulator pgenesis --modelName 2neurons --simSuffix Docker-small-test  --simDesc 2neurons --simTimeStepInSec 0.00005 --simTime 1 --columnDepth 3 --synapticProbability 0.1 --retX 5 --retY 8 --parallelMode 1 --numNodes 3 --modelInput A ' | tee test3.log
