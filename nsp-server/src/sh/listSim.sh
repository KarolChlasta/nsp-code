#!/bin/bash
# show list of experiments from s3
#x=`aws s3 ls s3://nsp-project/experiments/`
#echo $x| sed  's/PRE/\<\/br\>/g'

# Set default values for parameters

all="all$$.txt"
results="finished"
n=10

# Process command line arguments
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -n)
    n="$2"
    shift # past argument
    shift # past value
    ;;
    -h|--help)
    echo "Usage:./"`basename $0`" [-n]"
    echo "Show simulations from S3."
    echo " -u, --uri: uri path to s3 simulation name like s3://nsp-project/experiments/2022-11-29-003729_RetNet40_5x8_75_0_1_AWS-Docker/ "
    echo " -h, --help: show this help message"
    exit 0
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done

aws s3 ls s3://nsp-project/experiments/ | awk '{print $2}'| sed 's/\///g' > $all

for f in `tail -n $n $all `; do
res=$(aws s3 ls "s3://nsp-project/experiments/$f/results" | awk '{print $2}')

if [[ $res == "results/" ]]; then
  echo "$f: finished"
else
  echo "$f: not completed"
fi

done

rm $all
