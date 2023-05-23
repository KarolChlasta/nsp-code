#!/bin/bash
# script that execute simulations symulations from the file simulationsToRun.txt
# script generate history of executed simulations 
# input:
writeOutput.sh "Running NSP simulation manager."
writeOutput.sh "Load simulations into remote queue, or locally using a new PowerShell session."

while [ 1 -gt 0 ]
do
    runSimManagerS3Next.sh
    writeOutput.sh "Checking simulation queue in 3 minutes."
    sleep `expr 180`
done
