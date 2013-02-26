#!/bin/bash

port=$1
testname=$2

# "nohup sh -c 'sar 1 > /tmp/'$a'.out' &"

/root/cluster/command -b mongods "nohup sh -c '~ec2-user/mongomonitor.sh --port '${port}' dm-0 > /tmp/'${testname}'_mongostat.log 2>/dev/null' &" 
