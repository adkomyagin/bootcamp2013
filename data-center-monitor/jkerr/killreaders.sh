#!/bin/bash

ps -elf|grep mongo|grep reader.js|grep -v grep|while read line; do 
    pid=`echo $line|awk '{print $4}'`
    kill $pid
done
