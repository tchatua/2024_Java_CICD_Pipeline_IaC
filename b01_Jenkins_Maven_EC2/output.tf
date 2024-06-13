output "jenkins_maven_instance_id" {
  value = aws_instance.jenkins_maven.id
}

output "jenkins_maven_instance_ip_addr" {
  value       = aws_instance.jenkins_maven.private_ip
  description = "The private IP address of the jenkins_maven instance"
  #   depends_on = [
  #     # Security group rule must be created before this IP address could
  #     # actually be used, otherwise the services will be unreachable.
  #     aws_security_group_rule.local_access,
  #   ]
}

output "jenkins_maven_instance_public_ip" {
  value       = aws_instance.jenkins_maven.public_ip
  description = "Public IP of the jenkins_maven instance"
}