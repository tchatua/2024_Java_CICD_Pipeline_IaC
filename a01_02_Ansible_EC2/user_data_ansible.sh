#!/bin/bash

sudo su -

# Setup Hostname
hostnamectl set-hostname ansible-controller 

# Crate ansible administrator user
useradd ansadmin
passwd ansadmin
# for ubuntu (Alpha)
sudo mkdir -p /home/ansadmin
sudo chown ansadmin:ansadmin /home/ansadmin
sudo chmod 755 /home/ansadmin

# Add that ansible user to sudoers file: edit the /etc/sudoers
visudo
    ansadmin  ALL=(ALL) ALL NOPASSWORD: ALL 
service sshd restart

# Enable password-based login: etdit `/etc/ssh/sshd_config`
vim /etc/ssh/sshd_config
    PasaswordAuthentication yes
systemctl reload sshd

# Generate ssh keys
sudo su ansadmin 
PS1="ansadmin:>$"

# generate an RSA key with a length of 4096 bits
# [ansadmin@ansible-server]$ ssh-keygen -t rsa -b 4096

ssh-keygen -t rsa -b 4096 -C "tchattua@gmail.com"
# Generating public/private rsa key pair.
# Enter file in which to save the key (/home/ansadmin/.ssh/id_rsa):
# Created directory '/home/ansadmin/.ssh'.
# Enter passphrase (empty for no passphrase):
# Enter same passphrase again:
# Your identification has been saved in /home/ansadmin/.ssh/id_rsa
# Your public key has been saved in /home/ansadmin/.ssh/id_rsa.pub
# The key fingerprint is:
# SHA256:J6Bz547ubDalh+xrbjXbSwAjF4mUBqXOFaQ+Rysx+Xg tchattua@gmail.com
# The key's randomart image is:
# +---[RSA 4096]----+
# |  .==o..         |
# |   ++...         |
# |  *.+ =          |
# | + B = +         |
# |  B E . S .      |
# |   = o o++       |
# |     . =.+.      |
# |     .Xoo..      |
# |     XO+. ..     |
# +----[SHA256]-----+

# ######################################################
#                   Install Ansible with pip
# ######################################################

sudo su -
# yum install python -y
# yum install python-pip -y

# Update Package Index
sudo apt update
sudo apt install python3
# Optional: Set Python 3 as Default (Optional): By default, 
#       the python command often refers to Python 2. If you want the python command 
#       to refer to Python 3 instead, you can create a symbolic link:
sudo ln -s /usr/bin/python3 /usr/bin/python
apt install python3-pip -y
pip install ansible
mkdir /etc/ansible
touch /etc/ansible/ansible.cfg
touch /etc/ansible/hosts
touch /etc/ansible/inventory
# Go to GitHub repository ansible/ansible
# github.com/tchatua/ansible/blob/devel/examples/ansible.cfg
# 		Copy ansible.cfg URL and copy and paste the content in the /etc/ansible/ansible.cfg.
https://github.com/ansible/ansible/blob/stable-2.9/examples/ansible.cfg
vim /etc/ansible/ansible.cfg

ansible --version
# ansible [core 2.13.13]
#   config file = /etc/ansible/ansible.cfg
#   configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
#   ansible python module location = /usr/local/lib/python3.8/dist-packages/ansible
#   ansible collection location = /root/.ansible/collections:/usr/share/ansible/collections
#   executable location = /usr/local/bin/ansible
#   python version = 3.8.10 (default, Nov 22 2023, 10:22:35) [GCC 9.4.0]
#   jinja version = 3.1.3
#   libyaml = True

# To provide the password to the ssh command in a non-interactive way
# To install sshpass on Ubuntu
# sshpass -p 'your_password' ssh user@hostname
sudo apt update
sudo apt install sshpass
sshpass -V

# ##################################################
# Inventory file
# ##################################################
[ansible]
# 172.31.58.39
ansiblecontroller   ansible_host=172.31.58.39
[docker]
172.31.60.39
dockerhost   ansible_host=172.31.60.39


# ##################################################
# Ansible Commands adhoc
# ##################################################

ansible all -m ping -i /etc/ansible/inventory
