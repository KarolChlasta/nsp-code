# command to start container
export PATH=$PATH:/usr/local/nsp-server/src/sh/ 

writeOutput.sh 'NSP container started.'
configAWSCLI.sh
exec node ./src/js/index.js &
runSimManagerS3.sh