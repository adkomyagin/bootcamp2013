#!/bin/bash

monthcount=$1
daycount=$2
hostcount=$3
readercount=$4
testtime=300

for i in `seq 1 ${readercount}`; do 
    mongo --host mongod --eval "var monthCount=${monthcount}; var dayCount=${daycount}; var hostCount=${hostcount};" reader.js & 
    echo "launched ${i} readers"
    echo "waiting ${testtime} seconds before launching next reader..."
    sleep ${testtime}
done
