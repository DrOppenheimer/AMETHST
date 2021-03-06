#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#written 10-18-11
if [ $# -ne 2 ]                                                                                     # usage and exit if 4 args are not supplied
then
    echo
    echo "USAGE: >plot_pco_shell.sh <file_in> <file_out>"
    echo   
    echo "     <file_in>         : (string)  name of the input file (tab delimited file)"
    echo "     <file_out>        : (string)  name of the output file (tab delimited file)"
    echo     
    exit 1
fi

time_stamp=`date +%m-%d-%y_%H:%M:%S:%N`;  # create the time stamp month-day-year_hour:min:sec:nanosec

echo "# script generated by plot_qiime_pco_shell.sh to run plot_pco.r" >> plot_qiime_pco_script.$time_stamp.r
echo "# time stamp; $time_stamp" >> plot_qiime_pco_script.$time_stamp.r
echo "source(\"$DIR/qiime_dist_2_pco.r\")" >> plot_qiime_pco_script.$time_stamp.r
echo "qiime_dist_2_pco(file_in = \"$1\", file_out = \"$2\")" >> plot_qiime_pco_script.$time_stamp.r

R --vanilla --slave < plot_qiime_pco_script.$time_stamp.r

if [ -e plot_qiime_pco_script.$time_stamp.r ]
then
    rm plot_qiime_pco_script.$time_stamp.r
    #echo "Done with "plot_pco_script.$time_stamp.r
fi
