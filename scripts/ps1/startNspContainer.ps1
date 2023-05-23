param(
   [string] $tag = 'prod',
   [switch] $u,
   [string] $envFile = '../../config.nsp',
   [switch] $help
)
$containerName='nsp_genesis'

if ($help) {
   Write-Output "Usage: ./startNspContainer.sp1 [-tag TAG] [-u]"
   Write-Output "Create new container from the image based on tag."
   Write-Output " -tag TAG: tag of an image to run (prod, test or dev, default: prod)"
   Write-Output " -u : option to generate unique container name"
   Write-Output " -envFile : environment file"
   Write-Output " -help: show this help message"
   break
}
if ($u) {
   $containerName=$containerName+"_"+$PID
}

# Use parameters in script
Write-Output "tag: $tag"
Write-Output "u: $u"
Write-Output "envFile: $envFile"


docker run --env-file ../../config.nsp --name $containerName  -it karolchlasta/genesis-sim:${tag}
