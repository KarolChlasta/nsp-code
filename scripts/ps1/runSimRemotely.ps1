param(
   [string] $filePath = '..\..\nsp-queues\remoteNspQueue.nsp',
   [switch] $help
)

if ($help) {
   Write-Output "Usage: ./runSimRemotely.ps1  [-filePath FILE_PATH] COMMAND"
   Write-Output "Upload experiments to remote queue in cloud."
   Write-Output " -f, --file FILE_PATH: Path to file with experiments commands (default ..\..\nsp-queues\remoteNspQueue.nsp)"
   Write-Output " -h, -help: show this help message."
   break
}

# Use parameters in script
Write-Output "filePath: $filePath"


# run experiments from file
  aws s3 cp $filePath  s3://nsp-project/requests/remoteSimulationQueue.nsp
  


# run single simulation
#  docker exec $container bash -c '  /usr/local/nsp-server/src/sh/runSim.sh --simulator genesis --modelName RetNet40 --simSuffix HPI-Docker-small-test  --simDesc RetNet40 --simTimeStepInSec 0.00005 --simTime 1 --columnDepth 3 --synapticProbability 0.1 --retX 5 --retY 8 --parallelMode 0 --numNodes 1 --modelInput 0 '
