param(
   [string] $container = (docker ps -l -q --filter name=nsp_genesis),
   [switch] $help
)

if ($help) {
   Write-Output "Usage: ./listExp.ps1 [-c CONTAINER_NAME]"
   Write-Output "This script shows experiments from s3."
   Write-Output " -c, --container CONTAINER_NAME: The container parameter specifies the name or ID of the container to be acted upon."
   Write-Output " -h, -help: show this help message."
   break
}

# Use parameters in script
Write-Output "Container: $container"


docker exec $container bash -c '  /usr/local/nsp-server/src/sh/listSim.sh '
 