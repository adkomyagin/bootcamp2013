#!/bin/bash

threadcount=$1
conf_file=ramp.conf

for i in `seq 1 ${threadcount}`; do 
    sed -i -e "s/threads\=.*/threads\=${i}/" ${conf_file}

    echo "launching ${i} threads"

    ./mongo_testharness ${conf_file}
done

