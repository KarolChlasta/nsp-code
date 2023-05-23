param(
   [string] $tag = 'prod',
   [switch] $help
)
$containerName='nsp_genesis'

if ($help) {
   Write-Output "Usage: ./pullNspImage.ps1 [-t TAG]"
   Write-Output "Pull docker image from the Docker repository."
   Write-Output " -tag TAG: tag of an image to download (prod, test or dev, default: prod)"
   Write-Output " -h, -help: show this help message."
   break
}
if ($u) {
   $containerName=$containerName+"_"+$PID
}

# Use parameters in script
Write-Output "tag: $tag"
Write-Output "containerName: $containerName"

docker pull karolchlasta/genesis-sim:$tag