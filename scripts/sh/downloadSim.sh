
#!/bin/bash
# download files from simulation from s3

 
# Set default values for parameters

# Process command line arguments
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -u|--uri)
    experimentS3URI="$2"
    shift # past argument
    shift # past value
    ;;
    -h|--help)
    echo "Usage: ./downloadSim.sh [ -u URI]"
    echo "Download simulation from S3."
    echo " -u, --uri: uri path to s3 simulation name like s3://nsp-project/experiments/2022-11-29-003729_RetNet40_5x8_75_0_1_AWS-Docker/ "
    echo " -h, --help: show this help message"
    exit 0
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done

experimentName=`basename $experimentS3URI`
mkdir $experimentName
cd $experimentName
aws s3 sync  ${experimentS3URI} .

