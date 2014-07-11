#!/bin/bash

#This script loads the full chip with intial_data_load value, then it tests each location of the chip by loading and then looking for data_look, then after each tests
#its loads the location tested with data_load_after. This test takes ~1.2hours. 
#sidjos@gmail.com, sergo@fnal.gov

echo "Starting test:"

log=LOAD_Full_Chip.log

initial_data_load=0

#cleaning results from previous runs of same test

rm ./results/$log
rm ./root/tmp1_i.txt
rm ./root/tmp1_f.txt
rm ./root/tmp1.root

echo "-----cleaned previous results-----"

timestamp=$(date +%T)
echo $timestamp |tee -a $log

echo "----Loading Full chip with data $initial_data_load ......."

row_start=0
row_end=4

sleep 1s
while [ $row_end -le 128 ]
do
timestamp=$(date +%T)
echo $timestamp |tee -a $log
echo "----Loading Rows $row_start to $row_end with $initial_data_load"
python load_rowRange_Value.py $row_start $row_end $initial_data_load --go | grep 'match\|Testing Row\|shift\|Loaded\|Loading\|number of hits'| tee -a $log
sleep 1s
row_start=$[$row_start+4]
row_end=$[$row_end+4]
done

echo "----Loaded Full chip with data $initial_data_load......."
timestamp=$(date +%T)
echo $timestamp |tee -a $log

mv $log ./results/.

echo "End, Log stored in ./results/. "
