
 param(
   [string] $container = (docker ps -l -q --filter name=nsp_genesis),
   [switch] $help
)

if ($help) {
   Write-Output "Usage: ./runUnitTest.ps1 [-c CONTAINER_NAME]"
   Write-Output "Show consol output of the latest running container"
   Write-Output " -c, -container  CONTAINER_NAME: specifies the name or ID of the container to be acted upon"
   Write-Output " -h, -help: show this help message."
   break
}

# Use parameters in script
Write-Output "Container: $container"




 docker exec $container bash -c '  /usr/local/nsp-server/src/sh/runSim.sh --simulator genesis --modelName RetNet40 --simSuffix Docker-small-test-1  --simDesc RetNet40 --simTimeStepInSec 0.00005 --simTime 1 --columnDepth 3 --synapticProbability 0.1 --retX 5 --retY 8 --parallelMode 0 --numNodes 1 --modelInput 0 ' | Tee-Object test1.log
 #s3uri=`tail -n 1 test1.log`
 #./runUnitTestCheck.sh RetNet40 0 $s3uri
 #docker exec $containerName bash -c "/usr/local/nsp-server/script/sh/runUnitTestCheck.sh -m RetNet40 -p 0 -u $s3uri"

 docker exec $container bash -c '  /usr/local/nsp-server/src/sh/runSim.sh --simulator genesis --modelName RetNet40 --simSuffix Docker-small-test-2  --simDesc RetNet40 --simTimeStepInSec 0.00005 --simTime 1 --columnDepth 3 --synapticProbability 0.1 --retX 5 --retY 8 --parallelMode 0 --numNodes 1 --modelInput A ' | Tee-Object test2.log
 #s3uri=`tail -n 1 test2.log`
 #docker exec $containerName bash -c "/usr/local/nsp-server/script/sh/runUnitTestCheck.sh -m RetNet40 -p 12 -u $s3uri"

 docker exec $container bash -c '  /usr/local/nsp-server/src/sh/runSim.sh --simulator pgenesis --modelName 2neurons --simSuffix Docker-small-test-3  --simDesc 2neurons --simTimeStepInSec 0.00005 --simTime 1 --columnDepth 3 --synapticProbability 0.1 --retX 5 --retY 8 --parallelMode 1 --numNodes 3 --modelInput A ' | Tee-Object test3.log
