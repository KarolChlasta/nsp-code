#!/bin/bash
# save statistics to the global file and 
ststFile="$1"
dataFile="$2"
prefix="$3"
sts="${prefix}"

aws s3 cp  s3://nsp-project/experiments/globalStatistics.nsp $ststFile
for i in `tail -n 24 ${dataFile}`; do
  sts="${sts}  ${i}"; 
done; 
echo "${sts}" >> $ststFile
aws s3 cp $ststFile s3://nsp-project/experiments/globalStatistics.nsp

