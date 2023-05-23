#!/bin/bash
NSP_HOME="/usr/local/nsp-server"
export PATH=$PATH:/usr/local/genesis-2.4/genesis:/usr/local/genesis-2.4/pgenesis/bin:${NSP_HOME}/src/sh;
writeDebug.sh `basename "$0 started."`
writeOutput.sh "The arguments passed in are : $@"





function usage {
        writeOutput.sh "./$(basename $0) -h --> shows usage"
}
# Define the options that the script accepts
# The colon after each option indicates that the option requires an argument
# The h option is used for the help parameter
# Define the options that the script will accept
OPTS=`getopt -o h --long simulator:,modelName:,simSuffix:,simDesc:,simTimeStepInSec:,simTime:,columnDepth:,synapticProbability:,retX:,retY:,parallelMode:,numNodes:,modelInput:,help -- "$@"`

# Set the initial values of the variables


help=false

# Process the options
eval set -- "$OPTS"
while true ; do
  case "$1" in
    --simulator)
      simulator="$2"
      shift 2
      ;;
    --modelName)
      modelName="$2"
      shift 2
      ;;
    --simSuffix)
      simSuffix="$2"
      shift 2
      ;;
    --simDesc)
      simDesc="$2"
      shift 2
      ;;
    --simTimeStepInSec)
      simTimeStepInSec="$2"
      shift 2
      ;;
    --simTime)
      simTime="$2"
      shift 2
      ;;
    --columnDepth)
      columnDepth="$2"
      shift 2
      ;;
    --synapticProbability)
      synapticProbability="$2"
      shift 2
      ;;
    --retX)
      retX="$2"
      shift 2
      ;;
    --retY)
      retY="$2"
      shift 2
      ;;
    --parallelMode)
      parallelMode="$2"
      shift 2
      ;;
    --numNodes)
      numNodes="$2"
      shift 2
      ;;
    --modelInput)
      modelInput="$2"
      shift 2
      ;;
    -h | --help)
      help=true
	  shift
      ;;
    --)
      shift
      break
      ;;
    *)
      echo "Invalid option: $1"
      exit 1
      ;;
  esac
done

# Display help message if the -h or --help option was specified
if $help ; then
  cat <<EOF
Usage: runSim.sh [OPTION...]

Options:
  --simulator               Name of simulator
  --modelName               Name of the model to run
  --simSuffix        Suffix to be added to the experiment name
  --simDesc          Description of the experiment
  --simTimeStepInSec Time step of the simulation in seconds
  --simTime          Total simulation time in seconds
  --columnDepth             Depth of the columns in the model
  --synapticProbability     Probability of creating a synapse
  --retX                    X size of the retina
  --retY                    Y size of the retina
  --parallelMode            Mode to use for parallel execution
  --numNodes                Number of nodes to use for parallel execution
  --modelInput              Input file for the model
  -h, --help                Display this help message


Example: 
  ./runSim.sh --simulator genesis --modelName RetNet40 --simSuffix HPI-Docker-01  --simDesc RetNet40-description --simTimeStepInSec 0.00005 --simTime 1 --columnDepth 3 --synapticProbability 0.1 --retX 5 --retY 8 --parallelMode 0 --numNodes 1 --modelInput A
EOF
  exit 0
fi

if [ ! -n "$simulator" ]; then
    echo 'Simulator to run not set'
    exit 1
fi

if [ "$simulator" == "genesis" ]; then 

if [ ! -n "$modelName" ]; then
    modelName'RetNet40'
    echo  "Defult modelName set $modelName"
    exit 1
fi

if [ ! -n "$simSuffix" ]; then
    simSuffix='00'
	echo "Defult simSuffix set $simSuffix"
fi

if [ ! -n "$simDesc" ]; then
    simDesc='Experiment desctiption not set'
	echo "Defult simDesc set $simDesc"
fi

if [ ! -n "$simTimeStepInSec" ]; then
    simTimeStepInSec=0.00005
	echo "Defult simTimeStepInSec set $simTimeStepInSec"
fi
validateRealNumber.sh $simTimeStepInSec || exit -1


if [ ! -n "$simTime" ]; then
    simTime=1
    echo "Defult simTime set $simTime"
fi
validatePositiveInteger.sh $simTime || exit -1


if [ ! -n "$columnDepth" ]; then
    columnDepth=25
    echo "Defult columnDepth set $columnDepth"
fi
validatePositiveInteger.sh $columnDepth || exit -1


if [ ! -n "$synapticProbability" ]; then
    synapticProbability=0.1
    echo "Defult synapticProbability set $synapticProbability"
fi

validateRealNumber.sh $synapticProbability || exit -1


if [ ! -n "$retX" ]; then
    retX=5
    echo "Defult retX set $retX"
fi
validatePositiveInteger.sh $retX || exit -1


if [ ! -n "$retY" ]; then
    retY=8
    echo "Defult retY set $retY"
fi

validatePositiveInteger.sh $retY || exit -1
validateRange.sh $retX $retX $retY || exit -1
validateRange.sh $retY $retX $retY || exit -1


if [ ! -n "$parallelMode}" ]; then
    parallelMode=0
    echo "Defult parallelMode set $parallelMode"
fi

if [ ! -n "$numNodes" ]; then
    numNodes=1
    echo "Defult numNodes set $numNodes"
fi
validatePositiveInteger.sh $numNodes || exit -1

if [ ! -n "$modelInput" ]; then
    modelInput=0
    echo "Defult numNodes set $modelInput"
fi

elif [ "$simulator" == "pgenesis" ]; then

if [ ! -n "$modelName" ]; then
    modelName'2neurons'
    echo  "Defult modelName set $modelName"
fi

if [ ! -n "$simSuffix" ]; then
    simSuffix='00'
	echo "Defult simSuffix set $simSuffix"
fi

if [ ! -n "$simDesc" ]; then
    simDesc='Experiment desctiption not set'
	echo "Defult simDesc set $simDesc"
fi

if [ ! -n "$simTimeStepInSec" ]; then
    simTimeStepInSec=0.00005
	echo "Defult simTimeStepInSec set $simTimeStepInSec"
fi
validateRealNumber.sh $simTimeStepInSec || exit -1


if [ ! -n "$simTime" ]; then
    simTime=1
    echo "Defult simTime set $simTime"
fi
validatePositiveInteger.sh $simTime || exit -1


if [ ! -n "$columnDepth" ]; then
    columnDepth=25
    echo "Defult columnDepth set $columnDepth"
fi
validatePositiveInteger.sh $columnDepth || exit -1


if [ ! -n "$synapticProbability" ]; then
    synapticProbability=0.1
    echo "Defult synapticProbability set $synapticProbability"
fi

validateRealNumber.sh $synapticProbability || exit -1


if [ ! -n "$retX" ]; then
    retX=5
    echo "Defult retX set $retX"
fi
validatePositiveInteger.sh $retX || exit -1


if [ ! -n "$retY" ]; then
    retY=8
    echo "Defult retY set $retY"
fi

validatePositiveInteger.sh $retY || exit -1
validateRange.sh $retX $retX $retY || exit -1
validateRange.sh $retY $retX $retY || exit -1


if [ ! -n "$parallelMode}" ]; then
    parallelMode=1
    echo "Defult parallelMode set $parallelMode"
fi

if [ ! -n "$numNodes" ]; then
    numNodes=1
    echo "Defult numNodes set $numNodes"
fi
validatePositiveInteger.sh $numNodes || exit -1

if [ ! -n "$modelInput" ]; then
    modelInput=0
    echo "Defult numNodes set $modelInput"
fi

fi






modelInputNumber=$(echo $modelInput | sed '1,$s/P/10/g' | sed '1,$s/J/11/g' | sed '1,$s/A/12/g' | sed '1,$s/T/13/g' | sed '1,$s/K/14/g')

NSP_PATH='/usr/local/nsp-server'
cd $NSP_HOME
expFolderName="simulationFolder"
whoami
### Check for dir, if not found create it using the mkdir ##
[ ! -d "$expFolderName" ] && mkdir -p "$expFolderName"
cd "$expFolderName"
writeOutput.sh "Folder Cleared."
rm -rf *
ls -ltr

workingPath="${NSP_HOME}/${expFolderName}"

export SIM_WORK_DIR=$workingPath
startDate=$(date +"%Y-%m-%d %H:%M:%S")
(
echo "Scientist: ${nsp_scientist_name} ${nsp_scientist_surname}"
echo ""
echo "Email: ${nsp_scientist_email}"
echo ""
echo "Date of Starting Experiment: $startDate"
echo ""
echo "Project Information:"
echo "${nsp_project_info}"

echo 'Parameters:'
echo "1. simulator = $simulator"
echo "2. modelName = $modelName"
echo "3. simSuffix = $simSuffix"
echo "4. simDesc = $simDesc"
echo "5. simTimeStepInSec = $simTimeStepInSec"
echo "6. simTime = $simTime"
echo "7. columnDepth = $columnDepth"
echo "8. synapticProbability = $synapticProbability"
echo "9. retX = $retX"
echo "10. retY = $retY"
echo "11. parallelMode = $parallelMode"
echo "12. numNodes = $numNodes"
echo "13. modelInput = $modelInput ($modelInputNumber)"



showSystemInfo.sh
) | tee simulationInfo.out


# s3 folder for simulation
experimentS3FolderName=`date '+%Y-%m-%d-%T'`
experimentS3FolderName=$(echo $experimentS3FolderName | sed '1,$s/://g')

if [ "$simulator" == "pgenesis" ]; then
  experimentS3FolderName+="_${modelName}_${simTime}s_${simSuffix}"
else
  experimentS3FolderName+="_${modelName}_${retX}x${retY}_${columnDepth}_${modelInput}_${simTime}_${simSuffix}"
fi


cd "$workingPath"
writeOutput.sh 'Download model from s3.'
downloadModel.sh $modelName $workingPath
#apply parameters
mv "$modelName.g" "$modelName.g.org"
cat "$modelName.g.org" | sed '1,$s/\$modelName\$/'$modelName'/g'| sed '1,$s/\$simTimeStepInSec\$/'$simTimeStepInSec'/g' | sed '1,$s/\$simTime\$/'$simTime'/g' | sed '1,$s/\$columnDepth\$/'$columnDepth'/g' | sed '1,$s/\$synapticProbability\$/'$synapticProbability'/g' | sed '1,$s/\$retX\$/'$retX'/g' | sed '1,$s/\$retY\$/'$retY'/g' | sed '1,$s/\$modelInput\$/'$modelInputNumber'/g' > "$modelName.g"

ls -ltr
writeOutput.sh 'Upload model to experiment in s3.'
for f in `ls -1`; do aws s3 cp ${f} s3://nsp-project/experiments/${experimentS3FolderName}/model/${f}; done

writeOutput.sh 'Download model files .g and .p.'
for f in `aws s3 ls s3://nsp-project/experiments/${experimentS3FolderName}/model --recursive| awk '{print $4}'| grep -E "*.g|*.p"`; do aws s3 cp s3://nsp-project/${f} .; done

pwd
writeOutput.sh 'Downloaded files from s3.'
ls -ltr
date >> simulationInfo.out

if [ "$parallelMode" -eq "0" ]
    then
        writeOutput.sh  'nxgenesis started.'
        #screen -d -m 'genesis $modelName.g 1> $modelName.out 2> $modelName.out'
        nxgenesis -batch -notty $modelName.g 1> $modelName.out 2> $modelName.err


    else
        writeOutput.sh  'pgenesis started.'
        pgenesis -nodes $numNodes -nox -batch -notty $modelName.g 1> $modelName.out 2> $modelName.err
fi

#while [ $(ps -fe | grep "genesis" | grep "batch" | grep -v grep | grep -v defunct | wc -l) -gt 0 ]
#do
#    writeOutput.sh "sleep for 60"
#    sleep 60
#    ls -ltr *.dat ||  ls -ltr *.out
#    for f in `ls -1 | grep ".dat"`; do writeOutput.sh ""$f":"`tail -n 1 $f;`; done
#
#done

writeOutput.sh 'Simulation finished'
endDate=$(date +"%Y-%m-%d %H:%M:%S")
ls -ltr
echo 'End Time: '$endDate >> simulationInfo.out

calculatePeriod.sh --start-date "$startDate" --end-date "$endDate" >> simulationInfo.out
writeOutput.sh "Waiting 60s for .out files."
sleep 60
for f in `ls -1 | grep -E ".out|.sts|.err"`; do aws s3 cp $f s3://nsp-project/experiments/$experimentS3FolderName/results/$f; done
writeOutput.sh "Waiting 60s for .dat files."
sleep 60
for f in `ls -1 | grep -E ".dat"`; do aws s3 cp $f s3://nsp-project/experiments/$experimentS3FolderName/results/$f; done

writeOutput.sh "Results uploaded into s3://nsp-project/experiments/$experimentS3FolderName/results/"

writeOutput.sh "Save global statistics."
saveStat.sh "${NSP_HOME}/globalStatistics.sts" "${NSP_HOME}/${expFolderName}/${modelName}.out" " $experimentS3FolderName $simSuffix $simDesc $simTimeStepInSec $simTime $columnDepth $synapticProbability $retX $retY $parallelMode $numNodes $modelInput"
writeDebug.sh `basename "$0 finished."`
writeOutput.sh "Experiment finished and is accessible via uri:"
# uri will be used by other script downloadSim. do not touch
echo "s3://nsp-project/experiments/${experimentS3FolderName}"
