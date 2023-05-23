param(
   [string] $container = (docker ps -l -q --filter name=nsp_genesis),
   [string] $filePath = '../../nsp-queues/localNspQueue.nsp',
   [switch] $help
)

if ($help) {
   Write-Output "Usage: ./runSimLocally.ps1 [-c CONTAINER_NAME] [-f FILE_PATH]"
   Write-Output "run experiments from local queue."
   Write-Output " -c, -container CONTAINER_NAME: name of the container on wich to start unit test default latest container"
   Write-Output " -f, -filePath FILE_PATH: Path to file with experiments commands (default ../../localNspQueue.nsp)"
   Write-Output " -h, -help: show this help message."
   break
}

# Use parameters in script
Write-Output "Container: $container"
Write-Output "filePath: $filePath"


# run experiments from file
  docker cp $filePath  ${container}:/usr/local/nsp-server/localSimulationQueue.nsp
  docker exec $container bash -c ' /usr/local/nsp-server/src/sh/runSimLocally.sh'


# run single simulation
#  docker exec $container bash -c '  /usr/local/nsp-server/src/sh/runSim.sh --simulator genesis --modelName RetNet40 --simSuffix HPI-Docker-small-test  --simDesc RetNet40 --simTimeStepInSec 0.00005 --simTime 1 --columnDepth 3 --synapticProbability 0.1 --retX 5 --retY 8 --parallelMode 0 --numNodes 1 --modelInput 0 '
