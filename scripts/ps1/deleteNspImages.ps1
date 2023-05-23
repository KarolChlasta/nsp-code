
#!/bin/bash
# script that stop NSP container

param(
   [switch] $help
)
 
# Set default values for parameters

# Process command line arguments

if ($help) {
    Write-Output "Usage: ./deleteNspImages.sh "
    Write-Output "Delete all NSP images"
    Write-Output " -h, -help: show this help message."
    break
 }


# Use parameters in script



# Set the path to the folder containing the files

# Get a list of all files in the folder
$images = docker images --filter reference='karolchlasta/genesis-sim' -q

# Iterate over the list of files
foreach ($image in $images)
{
    # Do something with the file name
    Write-Output $image
    docker rmi -f $image
    # ...
}
