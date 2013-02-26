#!/bin/bash

monthcount=$1
daycount=$2
hostcount=$3
readercount=$4
testtime=300

for days in `seq 1 ${daycount}`; do
    echo "launching ${readercount} readers..."
    for i in `seq 1 ${readercount}`; do 
	mongo --host mongod --eval "var monthCount=${monthcount}; var dayCount=${days}; var hostCount=${hostcount};" reader.js & 
    done

    echo "`date` launched ${readercount} readers against ${monthcount} months and ${days} days"
    echo "waiting ${testtime} seconds before launching next reader set..."
    sleep ${testtime}

    echo "killing readers..."
    ./killreaders.sh
done
