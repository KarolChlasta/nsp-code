
#!/bin/bash
# Show running and stopped NSP containers
param(
   [switch] $all,
   [switch] $help
)
# Process command line arguments
if ($help) {
Write-Output "Usage: ./showNspContainers.sp1 [-a] [-help]"
Write-Output "Show running and stopped NSP containers."
Write-Output " -a, -all : show all containers running and stopped."
Write-Output " -h, -help: show this help message."
}
else {
# Use parameters in script
if($a){
    Write-Output "All NSP containers:"
    docker ps -a --filter name=nsp_genesis 
}else{
Write-Output "Running NSP containers:"
docker ps --filter name=nsp_genesis
}
}