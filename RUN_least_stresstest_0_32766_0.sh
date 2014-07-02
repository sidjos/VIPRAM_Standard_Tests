#!/bin/bash

#This script loads the full chip with intial_data_load value, then it tests each location of the chip by loading and then looking for data_look, then after each tests
#its loads the location tested with data_load_after. This test takes ~1.2hours. 
#sidjos@gmail.com, sergo@fnal.gov

echo "Starting test:"

log=least_stresstest_initialLoad0_Look32766_afterLoad0.log
image_name=least_stresstest_initialLoad0_Look32766_afterLoad0.png

initial_data_load=0
data_look=32766
data_load_after=0

rm ./results/$log
rm ./results/$image_name
rm ./root/tmp1_i.txt
rm ./root/tmp1_f.txt
rm ./root/tmp.root

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
for rowaddr in `seq 0 127`;
do
timestamp=$(date +%T)
echo $timestamp | tee -a $log
echo "----Testing Row $rowaddr"
python singleRowTest.py $rowaddr $data_look $data_load_after --go | grep 'match\|Testing Row\|shift\|Loaded\|number of hits'| tee -a $log
sleep 1s 
done

echo "Plotting mismatches...saving image in png file $log"
python eventMismatch.py $log| tee -a $log

rm checkData.txt

timestamp=$(date +%T)
echo $timestamp |tee -a $log

mv $log ./results/.
mv $image_name ./results/.
eog ./results/$image_name &

echo "Test End, Results stored in ./results/. "
