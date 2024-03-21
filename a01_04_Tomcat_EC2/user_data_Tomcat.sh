#!/bin/bash
sudo hostnamectl set-hostname Jenkins-Maven 

# #######################################################
#               Java Installation
# #######################################################
# Jenkins requires Java to run, yet not all Linux distributions include Java by default. 
# Additionally, not all Java versions are compatible with Jenkins.
# There are multiple Java implementations which you can use. 
# OpenJDK is the most popular one at the moment, we will use it in this guide.
# Update the Debian apt repositories, install OpenJDK 17, and check the installation with the commands:
sudo apt update
sudo apt install fontconfig openjdk-17-jre -y
java -version
# openjdk version "17.0.8" 2023-07-18
# OpenJDK Runtime Environment (build 17.0.8+7-Debian-1deb12u1)
# OpenJDK 64-Bit Server VM (build 17.0.8+7-Debian-1deb12u1, mixed mode, sharing)

