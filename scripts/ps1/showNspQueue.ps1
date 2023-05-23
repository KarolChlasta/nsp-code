param(
   [switch] $local,
   [switch] $remote,
   [string] $container,
   [switch] $help
)

$tmpFile="queueTmp${PID}.txt"

if ($help) {
   Write-Output "Usage: ./showNspQueue.ps1 [-local] [-remote] [-c CONTAINER_NAME] [-help]"
   Write-Output "show Nsp Queue remote or locally on the latest run NSP container."
   Write-Output " -c, -container CONTAINER_NAME: specifies the name or ID of the container to be acted upon"
   Write-Output " -h, -help: show this help message."
   break
}

# run experiments from file
if($local){
   # Use parameters in script
   if(!$container){
     $container = (docker ps -l -q --filter name=nsp_genesis)
   }
   Write-Output "Container: $container"
   docker cp  ${container}:/usr/local/nsp-server/localSimulationQueue.nsp $tmpFile
}
else {
   aws s3  cp  s3://nsp-project/requests/remoteSimulationQueue.nsp $tmpFile  
}

$fileInfo = Get-Item $tmpFile
$fileSize = $fileInfo.Length

if ($fileSize -le 5){
   Write-Output "Empty queue."
}

Get-Content $tmpFile
Remove-Item $tmpFile

