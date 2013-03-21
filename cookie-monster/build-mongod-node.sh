#!/bin/bash

export AWS_ACCESS_KEY=AKIAJROG3LMEIEHVUK7Q
export AWS_SECRET_KEY=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

echo "[10gen]
name=10gen Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64 
gpgcheck=0" | sudo tee -a /etc/yum.repos.d/10gen.repo

sudo yum -y update
sudo yum -y install sysstat
sudo yum -y install emacs
sudo yum -y install mongo-10gen-server


INSTANCE_ID=$(wget -q -O- http://169.254.169.254/latest/meta-data/instance-id)
ZONE=`ec2-describe-instance-status ${INSTANCE_ID}|head -1|awk '{print $3}'`

# set these to false if the EBS volumes are done already
DATA="true"
JOURNAL="true"

# set this to the level you want
RAID_LEVEL=5
DRIVES=8
DRIVE_SIZE=150
DRIVE_IOPS=250

echo
echo "instance: ${INSTANCE_ID}"
echo "zone: ${ZONE}"
echo
echo "/data"
echo "  RAID level: ${RAID_LEVEL}"
echo "  Drives: ${DRIVES}"
echo "  Drive Size: ${DRIVE_SIZE} GB"
echo "  Drive IOPs: ${DRIVE_IOPS}"
echo
echo -n "setup storage [Y/n]: "

if [ "$1" = "-y" ]; then
    answer="y"
else
    read answer
fi

if [ "${answer}" = "n" ]; then
    exit 0
fi

if [ "${DATA}" = "true" ]; then
    # setup the data devices
    #for x in `seq 1 $DRIVES`; do ec2-create-volume -s ${DRIVE_SIZE} -z ${ZONE} -t io1 -i ${DRIVE_IOPS}; done > vols.txt
    for x in `seq 1 $DRIVES`; do ec2-create-volume -s ${DRIVE_SIZE} -z ${ZONE}; done > vols.txt

    i=0
    for vol in $(awk '{print $2}' vols.txt); do
	i=$((i+1))
	ec2-attach-volume $vol -i ${INSTANCE_ID} -d /dev/sdh${i}

	# set the volumes to delete on termination
	ec2-modify-instance-attribute ${INSTANCE_ID} --block-device-mapping /dev/sdh${i}=${vol}:true
    done

    echo "waiting for devices..."
    while true; do 
	c=`ls -dl /dev/sdh*|wc -l`
	if [ "$c" = "$DRIVES" ]; then 
	    break
	else 
	    echo "$c devices attached"
	    sleep 1
	fi
    done

    DEVICES=$(for i in `seq 1 $DRIVES`; do echo -n "/dev/sdh${i} "; done)

    sudo mdadm --verbose --create /dev/md0 --level=${RAID_LEVEL} --chunk=256 --raid-devices=${DRIVES} ${DEVICES}

    echo "DEVICE ${DEVICES}" | sudo tee -a /etc/mdadm.conf
    sudo mdadm --detail --scan | sudo tee -a /etc/mdadm.conf

    sudo dd if=/dev/zero of=/dev/md0 bs=512 count=1
    sudo pvcreate /dev/md0
    sudo vgcreate vg0 /dev/md0

    sudo lvcreate -l 95%vg -n data vg0
    sudo lvcreate -l 5%vg -n log vg0

    sudo mke2fs -t ext4 -F /dev/vg0/data
    sudo mke2fs -t ext4 -F /dev/vg0/log

    sudo mkdir /data
    sudo mkdir /log

    echo '/dev/vg0/data /data ext4 defaults,auto,noatime,noexec 0 0' | sudo tee -a /etc/fstab
    echo '/dev/vg0/log /log ext4 defaults,auto,noatime,noexec 0 0' | sudo tee -a /etc/fstab


    sudo mount /data
    sudo mount /log

    sudo chown -R mongod:mongod /data /log

fi

if [ "${JOURNAL}" = "true" ]; then
    # setup journal device
    ec2-create-volume -s 30 -z ${ZONE} -t io1 -i 300 > journal-vols.txt

    vol=$(awk '{print $2}' journal-vols.txt)
    ec2-attach-volume $vol -i ${INSTANCE_ID} -d /dev/sdi

    # set the volumes to delete on termination
    ec2-modify-instance-attribute ${INSTANCE_ID} --block-device-mapping /dev/sdi=${vol}:true

    echo "waiting for devices..."
    while true; do 
	c=`ls -dl /dev/sdi*|wc -l`
	if [ "$c" = "1" ]; then 
	    break
	else 
	    echo "$c devices attached"
	    sleep 1
	fi
    done


    sudo pvcreate /dev/sdi
    sudo vgcreate vg1 /dev/sdi

    sudo lvcreate -l 100%vg -n journal vg1

    sudo mke2fs -t ext4 -F /dev/vg1/journal

    sudo mkdir /journal

    echo '/dev/vg1/journal /journal ext4 defaults,auto,noatime,noexec 0 0' | sudo tee -a /etc/fstab

    sudo mount /journal
    sudo ln -s /journal /data/journal

    sudo chown -R mongod:mongod /journal
fi

# update /etc/mongod.conf
sudo sed -i -e 's/logpath\=.*/logpath\=\/log\/mongod.log/' -e 's/dbpath\=.*/dbpath\=\/data/' /etc/mongod.conf

echo "setting limits..."
echo '
ulimit -f unlimited
ulimit -t unlimited
ulimit -v unlimited
ulimit -n 64000
ulimit -m unlimited
ulimit -u 32000
' | tee -a /etc/profile.d/custom.sh

echo "setting readahead"
blockdev --setra 32 /dev/mapper/vg0-data

echo "setting readahead in rc.local"
echo -e "\nblockdev --setra 32 /dev/mapper/vg0-data" >> /etc/rc.local

echo "done"
echo "run /etc/init.d/mongod start to start mongod"
