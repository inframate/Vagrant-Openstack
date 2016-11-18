# Vagrant-Openstack
Vagrantfile and script to set up an ubuntu 16.04 VM on VirtualBox and provision it with Openstack (devstack).

Based on the process described here : http://docs.openstack.org/developer/devstack/

Vagrantfile:
Uses "bento/ubuntu-16.04" Vagrant Box to set up an Ubuntu Xenial 16.04 Server with :
- 4096 MB RAM
- 4 CPU
- 1 NAT adapter
- 1 Host only adapter with IP address = "192.168.88.100"
- Hostname="OpenSTackVM"
- User/Password=vagrant/vagrant
- ssh key managed by vagrant ( to manage ssh keys uncomment the section (ssh key management) and change the path to your own key)

Provisionning script (Provision-script.sh):
- set Swappiness = 0 ( to avoid disk IO latency)
- Update package list on the new VM.
- Download devstack from https://git.openstack.org/openstack-dev/devstack
- Create local.conf file in the devstack directory with password presets for openstack services (all set to "Passw0rd")
- Change owner (vagrant) and permissions (770) on devstack directory
- Clean up before install: Run clean.sh with vagrant user (not root)
- Install Devstack : Run stack.sh with vagrant user (not root)
    
This should take a while depending on the host perfermance and Internet connexion.


