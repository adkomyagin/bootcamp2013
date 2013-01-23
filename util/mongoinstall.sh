#!/bin/bash

# this should be run on a linux install after downloading and expanding a mongo tgz
# wget http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.3.2.tgz
# 
# the location of where the mongo tgz was extracted
target=$1

if [ -z $target ]; then
    echo "usage: $0 <target directory>"
fi

if [ ! -f "/usr/bin/mongo" ]; then
    echo "run standard install first:"
    echo
    echo 'wget http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.3.2.tgz'
    echo 'tar zxvf mongodb-linux-x86_64-2.3.2.tgz'
    echo
    echo 'echo "[10gen]
name=10gen Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64
gpgcheck=0" | sudo tee -a /etc/yum.repos.d/10gen.repo'

    echo
    echo 'yum -y install mongo-10gen-server'
    echo 'yum -y install sysstat'

    exit 1
fi

if [ ! -d "$target" ]; then
    echo "target mongo location not found: $target"
    exit 1
fi


echo "removing old binaries..."
rm -v /usr/bin/mongo*
rm -v /usr/bin/bsondump

echo
echo "linking to new location..."
cd /usr/bin

ln -v -s $target/bin/bsondump bsondump
ln -v -s $target/bin/mongo mongo
ln -v -s $target/bin/mongod mongod
ln -v -s $target/bin/mongodump mongodump
ln -v -s $target/bin/mongoexport mongoexport
ln -v -s $target/bin/mongofiles mongofiles
ln -v -s $target/bin/mongoimport mongoimport
ln -v -s $target/bin/mongooplog mongooplog
ln -v -s $target/bin/mongoperf mongoperf
ln -v -s $target/bin/mongorestore mongorestore
ln -v -s $target/bin/mongos mongos
ln -v -s $target/bin/mongosniff mongosniff
ln -v -s $target/bin/mongostat mongostat
ln -v -s $target/bin/mongotop mongotop

echo "done"
