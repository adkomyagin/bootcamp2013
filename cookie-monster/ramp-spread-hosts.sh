#!/bin/bash

threadcount=$1
threads_per_host=$2
conf_file=/root/cookie/ramp.conf
hosts=("client-a" "client-b")

runid=`date +%s`
outdir=/tmp/mongo_testharness/${runid}
mkdir -p ${outdir}

echo "`date`: starting run: ${runid}"

hostcount=0

for i in `seq 1 2 ${threadcount}`; do 
    for j in `seq 1 ${i}`; do
	host_index=$(( $j % ${#hosts[@]} ))
	echo "launching process on ${hosts[$host_index]}"
	ssh ${hosts[$host_index]} "cd cookie; ./mongo_testharness ${conf_file}" &>  ${outdir}/${i}_${j}.log &
    done
    sleep 2
    echo "`date`: launched $i processes.  waiting for them to finish..."

    # wait for them to finish
    running=1
    while [ $running -eq 1 ] ; do
	pids=""
	for host in ${hosts[*]}; do
	    pids="${pids}`ssh $host pgrep mongo_test`"
	done

	if [ "$pids" = "" ]; then
	    running=0
        else
	    sleep 1
	    echo "`date`: waiting"
        fi
    done
done

echo "`date`: done run: ${runid}"


#for host in ${hosts[*]}; do
#    ssh $host "pkill mongo_test"
#    echo "shutdown test on $host"
#done
