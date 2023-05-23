
 param(
   [string] $container = (docker ps -l -q --filter name=nsp_genesis),
   [switch] $help
)

if ($help) {
   Write-Output "Usage: ./runSampleSim.ps1 [-c CONTAINER_NAME]"
   Write-Output "Run Sample Experiments on latest running NSP container"
   Write-Output " -c, -container CONTAINER_NAME: specifies the name or ID of the container to be acted upon"
   Write-Output " -h, -help: show this help message."
   break
}

# Use parameters in script
Write-Output "Container: $container"

 docker exec $container bash -c '  /usr/local/nsp-server/src/sh/runSim.sh --simulator genesis --modelName RetNet40 --simSuffix Docker-sample  --simDesc RetNet40 --simTimeStepInSec 0.00005 --simTime 1 --columnDepth 25 --synapticProbability 0.1 --retX 5 --retY 8 --parallelMode 0 --numNodes 1 --modelInput 0 ' | Tee-Object sampleExp1.log

 docker exec $container bash -c '  /usr/local/nsp-server/src/sh/runSim.sh --simulator genesis --modelName RetNet40 --simSuffix Docker-sample  --simDesc RetNet40 --simTimeStepInSec 0.00005 --simTime 1 --columnDepth 25 --synapticProbability 0.1 --retX 5 --retY 8 --parallelMode 0 --numNodes 1 --modelInput A ' | Tee-Object sampleExp2.log
 
 docker exec $container bash -c '  /usr/local/nsp-server/src/sh/runSim.sh --simulator genesis --modelName RetNet40 --simSuffix Docker-sample  --simDesc RetNet40 --simTimeStepInSec 0.00005 --simTime 1 --columnDepth 25 --synapticProbability 0.1 --retX 5 --retY 8 --parallelMode 0 --numNodes 1 --modelInput 1 ' | Tee-Object sampleExp3.log
 
$s3uri = Get-Content sampleExp1.log -Tail 1
.\downloadSim.ps1 -uri $s3uri
$s3uri = Get-Content sampleExp2.log -Tail 1
.\downloadSim.ps1 -uri $s3uri
$s3uri = Get-Content sampleExp3.log -Tail 1
.\downloadSim.ps1 -uri $s3uri
