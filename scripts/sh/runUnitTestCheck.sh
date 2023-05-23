
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -m|--model)
    modelName="$2"
    shift # past argument
    shift # past value
    ;;
    -p|--pattern)
    patern="$2"
    shift # past argument
    shift # past value
    ;;
    -u|--uri)
    uri="$2"
    shift # past argument
    shift # past value
    ;;
    -h|--help)
    echo "Usage: ./runUnitTestCheck.sh [-m MODEL] [-p PATERN] [-u URI]"
    echo "Test completion of simulation results"
    echo " -m, --model MODEL_NAME: name of simulation model "
    echo " -p, --patern PATERN: name of simulation patern "   
    echo " -u, --uri URI: name of s3 simulation URI "   
    echo " -h, --help: show this help message"
    exit 0
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done

if [ ! -n "$modelName" ]; then
    echo "Model parameter not set"
    exit 1
fi

if [ ! -n "$patern" ]; then
    echo "Patern parameter not set"
    exit 2
fi
if [ ! -n "$uri" ]; then
    echo "S3 uri parameter not set"
    exit 3
fi


# Use parameters in script
echo "modelName: $modelName"
echo "patern: $patern"
echo "uri: $uri"



bucketname=`basename $uri`



[ ! -d "$bucketname" ] && mkdir -p "$bucketname"
rm -rf "bucketname/*"

cd "$bucketname"
pwd
aws s3 sync  ${uri} .

find .

ret=`ls -1 ./results/simulationInfo.out | wc -l`
if [ ! $ret == 1 ] 
then
    echo "Simulation modelName test Failed. no file simulationInfo.out"
else
    echo "Simulation modelName test success. simulationInfo.out file exists"
fi

ret=`ls -1 ./results/${modelName}.out | wc -l` 
if [ ! $ret == 1 ] 
then
    echo "Simulation modelName test Failed. no file ${modelName}.out"
else
    echo "Simulation modelName test Success. ${modelName}.out exists"
fi

ret=`ls -1 ./results/${modelName}.err | wc -l` 
if [ ! $ret == 1 ] 
then
    echo "Simulation modelName test Failed. no file ${modelName}.err"
else
    echo "Simulation modelName test Success. ${modelName}.err exists"
fi

ret=`ls -1 ./results/${modelName}-${patern}-retina.dat | wc -l` 
if [ ! $ret == 1 ] 
then
    echo "Simulation modelName test Failed. no file ${modelName}-${patern}-retina.dat"
else
    echo "Simulation modelName test Success. ${modelName}-${patern}-retina.dat exists"
fi

ret=`ls -1 ./results/${modelName}-${patern}-column.dat | wc -l` 
if [ ! $ret == 1 ] 
then
    echo "Simulation modelName test Failed. no file ${modelName}-${patern}-column.dat"
else
    echo "Simulation modelName test Success. ${modelName}-${patern}-column.dat exists"
fi

cd ..
rm -drf "$bucketname"
