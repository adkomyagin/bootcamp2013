#!/bin/bash

group=$1

while true; do /root/cluster/command $group 'sar 1 1 |grep -A1 %user'; sleep 1; echo "****************"; done
