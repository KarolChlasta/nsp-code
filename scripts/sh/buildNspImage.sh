#!/bin/bash

# Set default values for parameters
tag=prod
branch=main
logName="docker_build$$.log"
logFolder='docker_builds_logs'
logPath="$HOME/$logFolder/$logName"
srcDockerImageFolder='nsp-server'

# Process command line arguments
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -t|--tag)
    tag="$2"
    shift # past argument
    shift # past value
    ;;
    -b|--branch)
    branch="$2"
    shift # past argument
    shift # past value
    ;;
    -h|--help)
    echo "Usage: ./"`basename $0`" [-t tag] [-b BRANCH]"
    echo "Build docker image from the code."
    echo " -t tag: tag for the image (prod, test or dev, default: prod)"
    echo " -b branch: branch to use (main, test or devevelop, default: main)"
    echo " -h: show this help message"
    exit 0
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done

# Use parameters in script
echo "tag: $tag"
echo "Branch: $branch"

srcFolderName="nsp-code-${tag}"

cd $HOME

if [ ! -d "$srcFolderName" ]; then
  mkdir "$srcFolderName"
else
  rm -rf "${srcFolderName}"
fi


if [ ! -d "$logFolder" ]; then
  mkdir "$logFolder"
fi

touch "$logPath"

git clone --recursive  https://karolchlasta@github.com/KarolChlasta/nsp-code.git -b $branch "${srcFolderName}"
cd "${srcFolderName}/${srcDockerImageFolder}"
#git clone --recursive  https://karolchlasta@github.com/KarolChlasta/nsp-model.git
docker build -t karolchlasta/genesis-sim:${tag} .  | tee "$logPath"

echo "log generated in $logPath file"
ls -ltr "$logPath"
