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

# #######################################################
#               Jenkins Installation
# #######################################################
# On Debian and Debian-based distributions like Ubuntu you can install Jenkins through apt.
# With the release of Debian 12, OpenJDK 11 is no longer included. 
# It has been replaced with OpenJDK 17, which is reflected in the instructions below.

# Long Term Support release
# A LTS (Long-Term Support) release is chosen every 12 weeks from the stream of regular releases 
# as the stable release for that time period. It can be installed from the debian-stable apt repository.
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y

# #######################################################
#               Start Jenkins 
# #######################################################
# You can enable the Jenkins service to start at boot with the command:
sudo systemctl enable jenkins

# You can start the Jenkins service with the command:
sudo systemctl start jenkins

# You can check the status of the Jenkins service using the command:
sudo systemctl status jenkins
sudo systemctl stop jenkins


# # #######################################################
# #               Firawall 
# # #######################################################
# # If you have a firewall installed, you must add Jenkins as an exception. 
# # You must change YOURPORT in the script below to the port you want to use. 
# # Port 8080 is the most common.

# YOURPORT=8080
# PERM="--permanent"
# SERV="$PERM --service=jenkins"

# firewall-cmd $PERM --new-service=jenkins
# firewall-cmd $SERV --set-short="Jenkins ports"
# firewall-cmd $SERV --set-description="Jenkins port exceptions"
# firewall-cmd $SERV --add-port=$YOURPORT/tcp
# firewall-cmd $PERM --add-service=jenkins
# firewall-cmd --zone=public --add-service=http --permanent
# firewall-cmd --reload

# # #######################################################
# #               Unlock Jenkins 
# # #######################################################

# cat /var/lib/jenkins/secrets/initialAdminPassword

# # #######################################################
# #               Install Maven 
# # #######################################################

# Downloading Apache Maven 3.9.6
cd /opt/
wget https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz
tar -xvzf apache-maven-3.9.6-bin.tar.gz
mv apache-maven-3.9.6 maven
cd maven/bin
./mvn -v
# Apache Maven 3.9.6 (bc0240f3c744dd6b6ec2920b3cd08dcc295161ae)
# Maven home: /opt/maven
# Java version: 17.0.10, vendor: Private Build, runtime: /usr/lib/jvm/java-17-openjdk-amd64
# Default locale: en, platform encoding: UTF-8
# OS name: "linux", version: "5.15.0-1055-aws", arch: "amd64", family: "unix"

mvn -v
# Command 'mvn' not found, but can be installed with:
# apt install maven

find / -name jvm
# /usr/share/gdb/auto-load/usr/lib/jvm
# /usr/lib/jvm
# /usr/lib/debug/usr/lib/jvm

# Setup Maven in the environment variables
sudo vim /etc/profile.d/maven.sh
# Add the following lines to the maven.sh file:
export JAVA_HOME=/usr/lib/jvm/java-1.17.0-openjdk-amd64
export M2_HOME=/opt/maven
export MAVEN_HOME=/opt/maven
export PATH=${M2_HOME}/bin:${PATH}
# Make the maven.sh file executable using the chmod command:
sudo chmod +x /etc/profile.d/maven.sh
# Execute the maven.sh script file with the source command to set up the new environment variables:
source /etc/profile.d/maven.sh

# Verify Maven Installation
mvn -version
# Apache Maven 3.9.6 (bc0240f3c744dd6b6ec2920b3cd08dcc295161ae)
# Maven home: /opt/maven
# Java version: 17.0.10, vendor: Private Build, runtime: /usr/lib/jvm/java-17-openjdk-amd64
# Default locale: en, platform encoding: UTF-8
# OS name: "linux", version: "5.15.0-1055-aws", arch: "amd64", family: "unix"

```bash
echo $PATH
```
/opt/maven/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin