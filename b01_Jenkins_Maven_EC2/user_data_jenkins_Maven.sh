#!/bin/bash
sudo hostnamectl set-hostname Jenkins-Maven 

# #######################################################
#               Java Installation
# #######################################################
URL: https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/
#  You can install jenkins using the rpm or by setting up the repo. 
# We will set up the repo so that we can update it easily in the future.
# 1. Get the latest version of jenkins from https://pkg.jenkins.io/redhat-stable/ and install
sudo yum update -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
# sudo dnf install java-17-amazon-corretto -y
# sudo yum install java-17-amazon-corretto -y
amazon-linux-extras install epel -y
amazon-linux-extras install java-openjdk11 -y


amazon-linux-extras uninstall epel -y
amazon-linux-extras remove java-openjdk11 -y

sudo yum update -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins

# # #######################################################
# #               Unlock Jenkins 
# # #######################################################

cat /var/lib/jenkins/secrets/initialAdminPassword




# # #######################################################
# # To Install Apache Maven and Java 8 on your EC2 instance
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
file $(which java)
# /usr/bin/java: symbolic link to `/etc/alternatives/java'

file /etc/alternatives/java
# /etc/alternatives/java: symbolic link to `/usr/lib/jvm/java-11-openjdk-11.0.22.0.7-1.amzn2.0.1.x86_64/bin/java'

vi ~/.bash_profile
M2_HOME=/opt/maven
M2=$M2_HOME/bin
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.22.0.7-1.amzn2.0.1.x86_64/bin/java
PATH=<Existing_PATH>:$M2_HOME:$M2:$JAVA_HOME

source ~/.bash_profile

mvn -v
# Apache Maven 3.9.6 (bc0240f3c744dd6b6ec2920b3cd08dcc295161ae)
# Maven home: /opt/maven
# Java version: 11.0.22, vendor: Red Hat, Inc., runtime: /usr/lib/jvm/java-11-openjdk-11.0.22.0.7-1.amzn2.0.1.x86_64
# Default locale: en_US, platform encoding: UTF-8
# OS name: "linux", version: "5.10.210-201.852.amzn2.x86_64", arch: "amd64", family: "unix"

### Setup maven on Jenkins console
1. Install maven plugin without restart  
#   - `Manage Jenkins` > `Jenkins Plugins` > `available` > `Maven Invoker`
  - `Manage Jenkins` > `Jenkins Plugins` > `available` > `Maven Integration`

2. Configure maven path
  - `Manage Jenkins` > `Global Tool` > `Maven`











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