#!/bin/bash
# script that execute experiments symulations from the file expFiletoRun
# script generate history of executed experiments
# input:



# Set default values for parameters
containerName=`docker ps -l -q --filter name=nsp_genesis`
expFiletoRun='localSimulationQueue.nsp'
expFiletoRunTmp='localSimulationQueueTmp.nsp'
expHistFile='localSimulationQueueHistory.nsp'
startCmd="'"
endCmd="'"
help1="Sample of the file $expFiletoRun with simulation commands"
help2="runSim.sh --simulator genesis --modelName RetNet40 --simSuffix HPI-Docker-test --simDesc RetNet40 --simTimeStepInSec 0.00005 --simTime 1 --columnDepth 3 --synapticProbability 0.1 --retX 5 --retY 8 --parallelMode 0 --numNodes 1 --modelInput 0"
help3="runSim.sh --simulator pgenesis --modelName 2neurons --simSuffix HPI-Docker-small-test  --simDesc 2neurons --simTimeStepInSec 0.00005 --simTime 1 --columnDepth 3 --synapticProbability 0.1 --retX 5 --retY 8 --parallelMode 1 --numNodes 3 --modelInput A"

# Process command line arguments
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -c|--container)
    containerName="$2"
    shift # past argument
    shift # past value
    ;;
    -h|--help)
    echo "Usage: ./runSimScheduler.sh [-c CONTAINER_NAME]"
    echo "Run experiments from the file."
    echo " -c, --container CONTAINER_NAME: name of the container on wich to start unit test (default latest container)"
    echo " -h, --help: show this help message"
    echo ""
    echo $help1
    echo $help2
    echo $help3
    exit 0
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done

dockerCmd="docker exec $containerName bash -c "

function runNextExperiment {
# script check if symulator is working
# if not execute next simulation from the list of planned simulations stored in file $expFiletoRun
# script generate history of executed experiments in file

if [ $(ps -fe| grep -v grep | grep -v defunct | grep runSim.sh | wc -l) -gt 0 ]
then
        echo `date` 'simulator is already working...'
else
        futureExpCnt=$(expr $(cat $expFiletoRun | wc -l) - 1)
        echo $futureExpCnt
        if [ $futureExpCnt -gt 0 ]
        then
          cat  $expFiletoRun | tail -n $futureExpCnt > $expFiletoRunTmp
        else
          > $expFiletoRunTmp
        fi
          nextExp=$(cat $expFiletoRun | head -n 1)
          echo $nextExp >> $expHistFile
          echo 'next simulation to run'
          echo $dockerCmd $startCmd '/usr/local/nsp-server/src/sh/'$nextExp $endCmd > localSimulation.sh
          chmod 755 localSimulation.sh
          ./localSimulation.sh
          echo 'future experiments'
          cp $expFiletoRunTmp  $expFiletoRun

fi
}

touch $expFiletoRun

expCnt=$(cat $expFiletoRun | wc -l)
echo $expCnt
if [ ! $expCnt -gt 0 ]
then
  echo "Add simulation's tasks to the file $expFiletoRun"
  echo " "
  echo $help1
  echo $help2
  echo $help3
fi

while [ $(cat $expFiletoRun | wc -l) -gt 0 ]
do
    runNextExperiment
    #./runNextExperiment.sh
    echo "sleep for 60*5s. Press CTR-C to finish"
    sleep 300
    cat $expFiletoRun
done

