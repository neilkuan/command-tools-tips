#!/bin/bash
# setup Jenkins on EC2 (Amazon Linux 2)
sudo yum update -y
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install java-1.8.0 -y
sudo amazon-linux-extras install epel
sudo yum install epel-release -y 
sudo yum-config-manager --enable epel
sudo yum install daemonize -y  
sudo yum install jenkins -y

sudo service jenkins start

sudo cat /var/lib/jenkins/secrets/initialAdminPassword
