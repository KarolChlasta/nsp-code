#!/bin/bash
# script check if symulator is working
# if not execute next simulation from the list of planned simulations stored in file $EXP_LIST_TO_RUN
# script generate history of executed experiments in file 

#cd $WORK_PATH
EXP_TO_RUN='remoteSimulation.sh'
EXP_LIST_TO_RUN='remoteSimulationQueue.nsp'
EXP_TMP='remoteSimulationQueueTmp.nsp'
EXP_HIST='remoteSimulationQueueHistory.nsp'
NSP_VER='v2.0'
if [ $(ps -fe| grep -v grep | grep -v defunct | grep runSim.sh | wc -l) -gt 0 ]
then
        writeOutput.sh `date` 'simulation engine is already running.'
else
        writeOutput.sh 'Get simulation from remote simulation queue.'     
        aws s3 cp s3://nsp-project/requests/${EXP_LIST_TO_RUN} .
        fs=`du -b $EXP_LIST_TO_RUN | awk '{print $1}'`
        if [ $fs -eq 0 ]
        then
          writeOutput.sh "NSP Container "`hostname`" has an empty remote simulation queue."
        else
          futureExpCnt=$(expr $(cat $EXP_LIST_TO_RUN | wc -l) - 1)
          if [ $futureExpCnt -gt 0 ]
          then
            cat  $EXP_LIST_TO_RUN | tail -n $futureExpCnt > $EXP_TMP    
          else
            writeOutput.sh 'Last simulation.'
            touch $EXP_TMP
          fi
          writeOutput.sh 'Update list of experiments in s3.'
          aws s3 cp ${EXP_TMP} s3://nsp-project/requests/${EXP_LIST_TO_RUN};

          nextExp=$(cat ${EXP_LIST_TO_RUN} | head -n 1)
          # update the history
          aws s3 cp s3://nsp-project/requests/$EXP_HIST $EXP_HIST
          echo `hostname` "$nextExp" >> $EXP_HIST
          aws s3 cp $EXP_HIST s3://nsp-project/requests/$EXP_HIST
        
          writeOutput.sh 'Next simulation to run.'
          echo "$nextExp" 
          echo "$nextExp" > $EXP_TO_RUN
          chmod 755 $EXP_TO_RUN
          ./$EXP_TO_RUN
        fi
fi
