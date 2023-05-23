
#!/bin/bash
# download files from simulation from s3

 filePath='../../nsp-queues/remoteNspQueue.nsp'
# Set default values for parameters

# Process command line arguments
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -f|--file)
    filePath="$2"
    shift # past argument
    shift # past value
    ;;
    -h|--help)
    echo "Usage: ./runSimRemotely.sh [ -f  FILE_PATH]"
    echo "Uload remote simulation queue to Cloud for execution."
    echo " -f, --file FILE_PATH: Path to file with experiments commands (default ..\..\nsp-queues\remoteNspQueue.nsp)"
    echo " -h, --help: show this help message"
    exit 0
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done

# run experiments from file
  aws s3 cp $filePath  s3://nsp-project/requests/remoteSimulationQueue.nsp
  

