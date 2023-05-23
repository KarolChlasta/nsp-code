param(
   [string] $container = (docker ps -l -q --filter name=nsp_genesis),
   [switch] $help
)

if ($help) {
   Write-Output "Usage: ./loginNspContainer.ps1 [-c CONTAINER_NAME]"
   Write-Output "This script allows you login to Docker container."
   Write-Output " -c, -container CONTAINER_NAME: The container parameter specifies the name or ID of the container to be acted upon."
   Write-Output " -h, -help : show this help message."
   break
}


Write-Output "Container: $container"
# Use parameters in script


docker exec -it $container bash