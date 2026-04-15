#!/bin/bash
component=$1
env=$2

dnf install ansible -y
cd /home/ec2-user
git clone https://github.com/sowjanya88s/ansible-roboshop-roles-tf.git
git pull
cd ansible-roboshop-roles-tf
ansible-playbook -e component=$component env=$environment roboshop.yaml