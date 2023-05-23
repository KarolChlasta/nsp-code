param(
   [string] $container = (docker ps -l -q --filter name=nsp_genesis),
   [switch] $help
)

if ($help) {
   Write-Output "Usage: ./showNspContainerLogs.sp1 [-c CONTAINER_NAME]"
   Write-Output "Show consol output of the latest running container"
   Write-Output " -c, -container CONTAINER_NAME: specifies the name or ID of the container to be acted upon"
   Write-Output " -help: show this help message"
   break
}

# Use parameters in script
Write-Output "Container: $container"


docker logs $container 