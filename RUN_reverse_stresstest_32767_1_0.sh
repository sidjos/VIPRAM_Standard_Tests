#!/bin/bash

#This script loads the full chip with intial_data_load value, then it tests each location of the chip by loading and then looking for data_look, then after each tests
#its loads the location tested with data_load_after. This test takes ~1.2hours. 
#sidjos@gmail.com, sergo@fnal.gov

echo "Starting test:"

log=reverse_stresstest_initialLoad32767_Look1_afterLoad0.log
image_name=reverse_stresstest_initialLoad32767_Look1_afterLoad0.png

initial_data_load=32767
data_look=1
data_load_after=0

rm $log
rm $image_name

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
python load_rowRange_Value.py $row_start $row_end $initial_data_load --go | grep 'match\|Testing Row\|shift\|Loaded|\Loading\|number of hits'| tee -a $log
sleep 1s
row_start=$[$row_start+4]
row_end=$[$row_end+4]
done

echo "----Loaded Full chip with data $initial_data_load......."
timestamp=$(date +%T)
echo $timestamp |tee -a $log

echo "----Testing Full chip with data $data_look and then loading $data_load_after."
sleep 1s
for rowaddr in `seq 127 -1 0`;
do
timestamp=$(date +%T)
echo $timestamp | tee -a $log
echo "----Testing Row $rowaddr"
python singleRowTest.py $rowaddr $data_look $data_load_after --go | grep 'match\|Testing Row\|shift\|Loaded\|number of hits'| tee -a $log
sleep 1s 
done

echo "Plotting mismatches...saving image in png file $log"
python eventMismatch.py $log| tee -a $log

eog $image_name &
rm checkData.txt

timestamp=$(date +%T)
echo $timestamp |tee -a $log
