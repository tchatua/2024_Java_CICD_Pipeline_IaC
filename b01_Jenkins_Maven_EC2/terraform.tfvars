# a01 Provider
region = "us-east-1"

# a01_04 General variables
name = "d05_jenkins_maven"

# a02 EC2 Webserver
# ami_id        = "ami-0c0b74d29acd0cd97"
instance_type = "t2.micro"
ami = "ami-02d7fd1c2af6eead0"
# key_name      = "public-ssh-key"
# tags: map of multiple strings
project       = "d05_CICD_with_Jenkins_Ansible_Kubernetes"
folder        = "d05_Udemy/d05_CICD/2024_Java_CICD_Pipeline_IaC/a01_01_Jenkins"
managedby     = "Terraform"
owner         = "Arristide Tchatua"
administrator = "tchattua@gmail.com"

# a03 Public Security Group
my_ip_address           = ["108.24.142.74/32"]
internet_open_ip        = ["0.0.0.0/0"]
ssh_port                = 22
tcp_protocol            = "tcp"
minus_one_protocol_code = "-1"
http_port               = [8080]
https_port              = 443
wildcard_port           = 0