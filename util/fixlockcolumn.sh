#!/bin/bash

sed -i -e "s/local.*:\(.*%\)/\1/" $1 
sed -i -e "s/multi.*:\(.*%\)/\1/" $1
sed -i -e "s/config.*:\(.*%\)/\1/" $1
sed -i -e "s/admin.*:\(.*%\)/\1/" $1
sed -i -e "s/smartPush.*:\(.*%\)/\1/" $1
