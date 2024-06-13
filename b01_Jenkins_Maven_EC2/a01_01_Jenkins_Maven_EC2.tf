resource "aws_instance" "jenkins_maven" {
  depends_on = [aws_security_group.web_sg]
  # ami                         = data.aws_ami.my_ami.id
  ami                         = var.ami 
  instance_type               = var.instance_type
  key_name                    = data.aws_key_pair.my_key.key_name
  associate_public_ip_address = true
  security_groups             = [aws_security_group.web_sg.name] # list of strings
  tags = {
    Name          = "${var.name}-controller"
    Project       = var.project
    Folder        = var.folder
    ManagedBy     = var.managedby
    Owner         = var.owner
    Administrator = var.administrator
  }
}

