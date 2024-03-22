output "docker_host_instance_id" {
  value = aws_instance.docker.id
}

output "docker_host_instance_ip_addr" {
  value       = aws_instance.docker.private_ip
  description = "The private IP address of the Docker instance"
  #   depends_on = [
  #     # Security group rule must be created before this IP address could
  #     # actually be used, otherwise the services will be unreachable.
  #     aws_security_group_rule.local_access,
  #   ]
}

output "docker_host_instance_public_ip" {
  value       = aws_instance.docker.public_ip
  description = "Public IP of the Docker instance"
}