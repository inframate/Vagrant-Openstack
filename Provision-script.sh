#!/bin/bash
# the box swappiness is 60 we need to decrease it to improve perfermance through using RAM rather than swap memory
sudo sysctl vm.swappiness=0
sudo echo "vm.swappiness=0" >> /etc/sysctl.conf

# Update apt
sudo apt-get update
sudo dpkg --configure -a
# Download DevStack
git clone https://git.openstack.org/openstack-dev/devstack

# The devstack repo contains a script that installs OpenStack and templates for configuration files

# Create a local.conf file with 4 passwords preset
touch ./devstack/local.conf
echo "[[local|localrc]]" > ./devstack/local.conf
echo "ADMIN_PASSWORD=Passw0rd" >> ./devstack/local.conf
echo "DATABASE_PASSWORD=$""ADMIN_PASSWORD" >> ./devstack/local.conf
echo "RABBIT_PASSWORD=$""ADMIN_PASSWORD" >> ./devstack/local.conf
echo "SERVICE_PASSWORD=$""ADMIN_PASSWORD" >> ./devstack/local.conf

# correct permission on devstack 
sudo chown -R vagrant devstack
chmod 770 devstack

# This is the minimum required config to get started with DevStack.

# Optional : Add Stack User
# Devstack should be run as a non-root user with sudo enabled (standard logins to cloud images such as “ubuntu” or “cloud-user” are usually fine).
# You can quickly create a separate stack user to run DevStack with
# devstack/tools/create-stack-user.sh; su stack

# Start the install
cd devstack
# in case of provisioning after an aborted install we need to clean before installing
su -c "source ./clean.sh" vagrant
su -c "source ./stack.sh" vagrant
# This will take a 15 - 20 minutes, largely depending on the speed of your internet connection. 
# Many git trees and packages will be installed during this process.