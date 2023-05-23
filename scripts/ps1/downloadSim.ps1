param([
   Parameter(Mandatory=$true)]
   [string] $uri,
   [switch] $help
)

if ($help) {
   Write-Output "Usage: ./downloadSim.sh [ -uri URI]"
   Write-Output "Download experiments from S3."
   Write-Output " -uri URI: uri path to s3 simulation name like s3://nsp-project/experiments/2022-11-29-003729_RetNet40_5x8_75_0_1_AWS-Docker/ "
   Write-Output " -h, -help: show this help message."
   break
}

# Use parameters in script
Write-Output "Container: $container"
Write-Output "uri: $uri"

# Get the parent folder of the S3 URI using Split-Path
$folderName = Split-Path $uri -Leaf

# Print the folder name
Write-Output "Folder name: $folderName"

New-Item -ItemType Directory -Name $folderName
aws s3 sync  "$uri" $folderName
