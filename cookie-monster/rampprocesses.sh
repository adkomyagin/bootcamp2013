#!/bin/bash

threadcount=$1
conf_file=ramp.conf

runid=`date +%s`
outdir=/tmp/mongo_testharness/${runid}
mkdir -p ${outdir}

echo "`date`: starting run: ${runid}"

for i in `seq 1 ${threadcount}`; do 

    for j in `seq 1 ${i}`; do
	./mongo_testharness ${conf_file} &>  ${outdir}/${i}_${j}.log &
    done
    sleep 2
    echo "`date`: launched $i processes.  waiting for them to finish..."

    # wait for them to finish
    until [ "`pgrep mongo_test`" = ""  ]; do
	sleep 1
	echo "`date`: waiting"
    done
done

echo "`date`: done run: ${runid}"
