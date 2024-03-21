resource "aws_security_group" "web_sg" {
  name        = "${var.name}-sg"
  description = "Allow the internet traffic"
  # vpc_id      = data.terraform_remote_state.s3_backend.outputs.VPC_ID
  tags = {
    Name = "${var.name}-sg"
  }
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = var.tcp_protocol
    cidr_blocks = var.my_ip_address
  }

  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = var.tcp_protocol
    cidr_blocks = var.internet_open_ip
  }

  ingress {
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = var.tcp_protocol
    cidr_blocks = var.internet_open_ip
  }

  egress {
    from_port   = var.wildcard_port
    to_port     = var.wildcard_port
    protocol    = var.minus_one_protocol_code
    cidr_blocks = var.internet_open_ip
  }
}
