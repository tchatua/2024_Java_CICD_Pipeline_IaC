#!/bin/bash
sudo hostnamectl set-hostname tomcat-server 

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
#               Install Tomcat
# #######################################################
cd /opt/
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.87/bin/apache-tomcat-9.0.87.tar.gz
tar -xvzf apache-tomcat-9.0.87.tar.gz
mv apache-tomcat-9.0.87 tomcat 
cd tomcat/bin/ 
./startup.sh
# Using CATALINA_BASE:   /opt/tomcat
# Using CATALINA_HOME:   /opt/tomcat
# Using CATALINA_TMPDIR: /opt/tomcat/temp
# Using JRE_HOME:        /usr
# Using CLASSPATH:       /opt/tomcat/bin/bootstrap.jar:/opt/tomcat/bin/tomcat-juli.jar
# Using CATALINA_OPTS:
# Tomcat started.

# To access Tomcat from the browser UI:
# http://100.25.21.76:8080/
# Click on `Manager App` 
# By default the Manager is only accessible from a browser running on the same machine as Tomcat. 
# If you wish to modify this restriction, you'll need to edit the Manager's context.xml file.

# #####################################################################################
#               context.xml file updated in the webapp directory
# #####################################################################################
cd /opt/tomcat/
find / -name context.xml
# /opt/tomcat/conf/context.xml
# /opt/tomcat/webapps/manager/META-INF/context.xml      # --> This one
# /opt/tomcat/webapps/host-manager/META-INF/context.xml # --> This one
# /opt/tomcat/webapps/docs/META-INF/context.xml
# /opt/tomcat/webapps/examples/META-INF/context.xml

vim /opt/tomcat/webapps/host-manager/META-INF/context.xml 
vim /opt/tomcat/webapps/host-manager/META-INF/context.xml 
# Comment this 2 lines
# <!--  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
#   allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" /> -->
cd tomcat/bin/ 
./shutdown.sh
./startup.sh
# To access Tomcat from the browser UI:
# http://100.25.21.76:8080/

# #####################################################################################
#               tomcat-users.xml file updated in the tomcat/conf/ directory
# Update users information in the tomcat-users.xml file
# #####################################################################################
# goto tomcat home directory and Add below users to conf/tomcat-users.xml file
cd tomcat/conf/
vim tomcat-users.xml

<role rolename="manager-gui"/>
<role rolename="manager-script"/>
<role rolename="manager-jmx"/>
<role rolename="manager-status"/>
<user username="admin" password="admin" roles="manager-gui, manager-script, manager-jmx, manager-status"/>
<user username="deployer" password="deployer" roles="manager-script"/>
<user username="tomcat" password="s3cret" roles="manager-gui"/>
# Restart serivce and try to login to tomcat application from the browser. This time it should be Successful

# #####################################################################################
#               create link files for tomcat startup.sh and shutdown.sh 
# #####################################################################################
# ln -s /opt/apache-tomcat-<version>/bin/startup.sh /usr/local/bin/tomcatup
ln -s /opt/tomcat/bin/startup.sh /usr/local/bin/tomcatup
# ln -s /opt/apache-tomcat-<version>/bin/shutdown.sh /usr/local/bin/tomcatdown
ln -s /opt/tomcat/bin/shutdown.sh /usr/local/bin/tomcatdown

tomcatup
tomcatdown
