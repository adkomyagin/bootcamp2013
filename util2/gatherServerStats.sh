#!/bin/bash

source .bash_profile

set -m

testName=$1
sampleSecs=$2

echo `date +%T` ": Lauching gatherServerStats: " $testName ":" $sampleSecs

rm -rf $testName
mkdir $testName

mongostat --noheaders --all -n $sampleSecs 1 > $testName\/$testName.mongostat.out &
/usr/bin/sar -u 1 $sampleSecs > $testName\/$testName.sar.u.out &
/usr/bin/sar -b 1 $sampleSecs > $testName\/$testName.sar.b.out &
/usr/bin/sar -B 1 $sampleSecs > $testName\/$testName.sar.B.out &
mongo --eval "var testName='$testName'; var sampleSecs=$sampleSecs" getMongoPeriodStats.js > $testName\/$testName.mongoPeriodStats.out &

wait;

tar -zcf $testName.tgz $testName

echo `date +%T` ": Exiting gatherServerStats"
