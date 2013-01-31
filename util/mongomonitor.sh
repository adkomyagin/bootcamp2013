#!/bin/bash

# first hack at a script to spit out mongostat, cpu and iostat metrics on
# a single line

# needs to have a better timestamp that includes the date as well as the time for longer running tests

# may want to add code to capture the mongod log for the duration as well

# device to monitor
device=$1

mongostat > /tmp/mongostat.log &
mongostat_pid=$!

iostat -xk 1 > /tmp/iostat.log &
iostat_pid=$!

trap "{ kill $mongostat_pid; kill $iostat_pid; }" EXIT

echo "test=$testname" 1>&2
echo "device=$device" 1>&2
echo "mongostat pid=$mongostat_pid" 1>&2
echo "iostat pid=$iostat_pid" 1>&2

sleep 5

# build the header

mongoline=`tail -50 /tmp/mongostat.log|grep insert|tail -1|sed -e 's/idx miss %/%idx-miss/' -e 's/locked db/locked-db/'`
cpuline=`tail -50 iostat.log | grep avg-cpu|tail -1|sed -e 's/avg-cpu://'`
deviceline=`tail -50 iostat.log | grep Device: | tail -1`
echo $mongoline $cpuline $deviceline | sed -e 's/\\s*/ /g' -e 's/ /\t/g'

while true; do
    # pull a line from mongostat and iostat
    mongoline=`tail -1 /tmp/mongostat.log|sed -e 's/*//g'`
    cpuline=`tail -50 /tmp/iostat.log | grep -A1 avg-cpu|tail -1`
    deviceline=`tail -50 /tmp/iostat.log | grep $device | tail -1`

    echo $mongoline $cpuline $deviceline | sed -e 's/ /\t/g'
    sleep 1
done
