#!/bin/bash
# show status of simulation 
# input:
#   simulation folder path

 cd /usr/local/nsp-server/simulationFolder/
 find . | grep -i .dat
 echo "Progress of simulation execution:"
 for f in `ls -1 * | grep ".dat"`; do echo ""$f":"`tail -n 1 $f;`; done