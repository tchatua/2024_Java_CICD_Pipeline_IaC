resource "aws_instance" "docker" {
  depends_on = [aws_security_group.web_sg]
  # ami                         = data.aws_ami.my_ami.id
  ami                         = "ami-0cd59ecaf368e5ccf"
  instance_type               = var.instance_type
  key_name                    = data.aws_key_pair.my_key.key_name
  associate_public_ip_address = true
  security_groups             = [aws_security_group.web_sg.name] # list of strings
  tags = {
    Name          = "${var.name}-host"
    Project       = var.project
    Folder        = var.folder
    ManagedBy     = var.managedby
    Owner         = var.owner
    Administrator = var.administrator
  }
}

