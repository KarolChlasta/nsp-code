param(
   [string] $container = (docker ps -l -q --filter name=nsp_genesis),
   [switch] $help
)

if ($help) {
   Write-Output "Usage: ./stopNspContainer.ps1 [-c CONTAINER_NAME] [-help]"
   Write-Output "This script allows you to stop NSP container."
   Write-Output " -c, -container CONTAINER_NAME: The container parameter specifies the name or ID of the container to be acted upon."
   Write-Output " -h, -help: show this help message."
   break
}

# Use parameters in script
Write-Output "Container: $container"


docker stop $container 
docker rm  $container
Write-Output "NSP container $container was deleted."