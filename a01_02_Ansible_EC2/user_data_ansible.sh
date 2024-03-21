#!/bin/bash

sudo su -

# Setup Hostname
hostnamectl set-hostname ansible-server 

# Crate ansible administrator user
useradd ansadmin
passwd ansadmin
#
sudo usermod -d /home/ansadmin ansadmin # for ubuntu (Alpha)
sudo adduser --create-home username # for ubuntu (Alpha)
# If Alpha do not word
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

[ansadmin@ansible-server]$ ssh-keygen
# Generating public/private rsa key pair.
# Enter file in which to save the key (/home/user/.ssh/id_rsa):
# Enter passphrase (empty for no passphrase):
# Enter same passphrase again:
# Your identification has been saved in /home/user/.ssh/id_rsa.
# Your public key has been saved in /home/user/.ssh/id_rsa.pub.
# The key fingerprint is:
# SHA256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx user@hostname
# The key's randomart image is:
# +---[RSA 2048]----+
# |       .o+.      |
# |    o  +B.       |
# | . . .+=B.       |
# |  + . o*+.       |
# | . =  o.S.       |
# |  .  .           |
# |                 |
# |                 |
# |                 |
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
apt install python3-pip

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


# To install sshpass on Ubuntu
sudo apt update
sudo apt install sshpass
sshpass -V
