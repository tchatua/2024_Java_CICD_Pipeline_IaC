#!/bin/bash
sudo hostnamectl set-hostname docker-host
sudo su -

# ######################################################################################
#               To install Docker on Ubuntu, you can follow these steps:
# ######################################################################################

# 1. Update Package Index: Ensure your Ubuntu package index is up-to-date:
```bash
sudo apt update
```
# 2. Install Prerequisites: Install the necessary packages to allow apt to use a repository over HTTPS:
```bash
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
```

# 3. Add Docker’s Official GPG Key: Add Docker’s official GPG key to your system:
```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

# 4. Add Docker Repository: Add the Docker repository to your APT sources:
```bash
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

# 5. Update Package Index: Update the apt package index once again after adding the repository:
```bash
sudo apt update
```

# 6. Install Docker: Install Docker CE (Community Edition):
```bash
sudo apt install docker-ce
```

# 7. Verify Installation: After installation, you can verify that Docker is installed correctly by running the following command which will output Docker version:
```bash
docker --version
```

# 8. Run Docker Without Sudo (Optional): By default, Docker requires sudo privileges to run commands. 
#         If you want to use Docker as a non-root user, you can add your user to the docker group:
```bash
sudo usermod -aG docker ${USER}
```

# Remember to log out and back in or run su - ${USER} to apply the changes. After that, you should be able to run Docker commands without sudo.

# ######################################################################################
#               How to use Tomcat Docker Container image
# ######################################################################################

# Run the default Tomcat server (CMD ["catalina.sh", "run"]):
```bash
docker run -it --rm tomcat:9.0
```
# You can test it by visiting http://container-ip:8080 in a browser or, 
    # if you need access outside the host, on port 8888:
```bash
docker run -it --rm -p 8888:8080 tomcat:9.0
```
# You can then go to http://localhost:8888 or http://host-ip:8888 in a browser 
#     (noting that it will return a 404 since there are no webapps loaded by default).

# The default Tomcat environment in the image is:
CATALINA_BASE:   /usr/local/tomcat
CATALINA_HOME:   /usr/local/tomcat
CATALINA_TMPDIR: /usr/local/tomcat/temp
JRE_HOME:        /usr
CLASSPATH:       /usr/local/tomcat/bin/bootstrap.jar:/usr/local/tomcat/bin/tomcat-juli.jar

# The configuration files are available in 
/usr/local/tomcat/conf/
# By default, no user is included in the "manager-gui" role required to operate the "/manager/html" web application. 
# If you wish to use this app, you must define such a user in 
tomcat-users.xml

# ######################################################################################
#               Install Tomcat Container on my Docker Host(CLI)
# ######################################################################################
docker pull tomcat
docker run -d --name tomcat-container -p 8081:8080 tomcat
docker exec -it tomcat-container /bin/bash
cd webapps.dist
cp -R * ../webapps
exit 
docker stop tomcat-container

docker run -d --name tomcat2 -p 8082:8080 tomcat:latest

