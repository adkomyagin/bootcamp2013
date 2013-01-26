source gatherRemoteStats.conf

if [ "$#" -ne 2 ]; then
    echo "Usage: gatherRemoteStats.sh <testName> <durationSec>"
    exit 1
fi

if [ ! -d "$testResultsDir" ]; then
    echo "Test results directory does not exist: $testResultsDir"
    exit 1
fi

testName=$1
sampleSecs=$2

echo `date +%T` ": Launching gatherRemoteStats : " $testName ":" $sampleSecs

scp -B -q -i $pemFile gatherServerStats.sh $remoteUser@$remoteHost:$remoteDir\/gatherServerStats.sh
scp -B -q -i $pemFile getMongoPeriodStats.js $remoteUser@$remoteHost:$remoteDir\/getMongoPeriodStats.js

ssh -i $pemFile $remoteUser@$remoteHost $remoteDir\/gatherServerStats.sh $testName $sampleSecs

scp -B -q -i $pemFile $remoteUser@$remoteHost:$testName.tgz $testResultsDir\/$testName.tgz
tar -C $testResultsDir -xf $testResultsDir\/$testName.tgz

echo `date +%T` ": Exiting gatherRemoteServerStats"
