output "maven_instance_id" {
  value = aws_instance.maven.id
}

output "maven_instance_private_ip_addr" {
  value       = aws_instance.maven.private_ip
  description = "The private IP address of the webserver instance"
  #   depends_on = [
  #     # Security group rule must be created before this IP address could
  #     # actually be used, otherwise the services will be unreachable.
  #     aws_security_group_rule.local_access,
  #   ]
}

output "maven_instance_public_ip" {
  value       = aws_instance.maven.public_ip
  description = "Public IP of the webserver instance"
}