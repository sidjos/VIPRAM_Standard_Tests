#!/bin/bash

rm logfile_singlerowtest.log
echo "Starting test:"

data=32766
data_load=32767

echo "----Testing Full chip with data $data and data_load $data_load."

for rowaddr in `seq 0 127`;
do
timestamp=$(date +%T)
echo $timestamp
echo $timestamp >> logfile_singlerowtest.log
echo "----Testing Row $rowaddr"
python singleRowTest.py $rowaddr $data $data_load --go | grep 'match\|Testing Row\|shift\|Loaded\|number of hits'| tee -a logfile_singlerowtest.log
sleep 1s 
done
