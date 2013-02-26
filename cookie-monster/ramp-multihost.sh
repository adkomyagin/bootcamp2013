#!/bin/bash

# use the --noramp option to just do a single run at the given number of threads
if [ "$1" = "--noramp" ]; then
    shift 1
    threadcount=$1
    start=$threadcount
    step=$threadcount
else
    threadcount=$1
    step=$2
    start=$step
fi


conf_file=/root/cookie/ramp.conf
#hosts=("client-b" "client-c" "client-d" "client-e" "client-f" "client-g")
hosts=("ec2-54-242-221-21.compute-1.amazonaws.com" "ec2-50-17-143-235.compute-1.amazonaws.com" "ec2-50-16-141-53.compute-1.amazonaws.com" "ec2-184-73-30-236.compute-1.amazonaws.com" "ec2-54-242-90-72.compute-1.amazonaws.com" "ec2-54-242-95-101.compute-1.amazonaws.com" "ec2-174-129-44-7.compute-1.amazonaws.com" "ec2-107-21-174-50.compute-1.amazonaws.com" "ec2-50-16-5-144.compute-1.amazonaws.com" "ec2-174-129-63-2.compute-1.amazonaws.com" "ec2-54-242-67-121.compute-1.amazonaws.com" "ec2-50-17-159-4.compute-1.amazonaws.com" "ec2-107-20-47-104.compute-1.amazonaws.com" "ec2-54-234-138-191.compute-1.amazonaws.com" "ec2-23-20-247-109.compute-1.amazonaws.com" "ec2-54-242-95-82.compute-1.amazonaws.com")

runid=`date +%s`
outdir=/tmp/mongo_testharness/${runid}
mkdir -p ${outdir}

echo "`date`: starting run: ${runid}"

hostcount=0

for i in `seq ${start} ${step} ${threadcount}`; do 
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
