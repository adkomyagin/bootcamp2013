#!/bin/bash

sudo cp ~ec2-user/.ssh/authorized_keys /root/.ssh/authorized_keys

sudo sed -i 's/PermitRootLogin forced-commands-only/PermitRootLogin without-password/' /etc/ssh/sshd_config

sudo /etc/init.d/sshd restart
