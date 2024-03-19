data "aws_key_pair" "my_key" {
  key_name = "public-ssh-key"
}

# data "aws_ami" "my_ami" {
#   most_recent = true
#   owners      = ["137112412989"]

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-kernel-*-x86_64-gp2"]
#   }
# }
