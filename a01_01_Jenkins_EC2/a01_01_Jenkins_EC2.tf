resource "aws_instance" "jenkins" {
  #   depends_on = [ aws_security_group.web_sg ]
  ami                         = data.aws_ami.my_ami.id
  instance_type               = var.instance_type
  key_name                    = data.aws_key_pair.my_key.key_name
  associate_public_ip_address = true
  # security_groups             = [aws_security_group.web_sg.name] # list of strings
  tags = {
    Name          = "${var.name}-jenkins"
    Project       = var.project
    Folder        = var.folder
    ManagedBy     = var.managedby
    Owner         = var.owner
    Administrator = var.administrator
  }
}
