#!/bin/bash

#This script runs all the stress tests, takes too long.  
#sidjos@gmail.com, sergo@fnal.gov


echo "Starting script_1:"
./RUN_stresstest_0_32766_32767.sh

echo "Starting script_2:"
./RUN_stresstest_32767_1_0.sh

echo "Starting script_3:"
./RUN_reverse_stresstest_0_32766_32767.sh

echo "Starting script_4:"
./RUN_reverse_stresstest_32767_1_0.sh

echo "Starting script_5"
./RUN_least_stresstest_0_32766_0.sh

echo "Starting script_5"
./RUN_least_stresstest_32767_1_32767.sh
