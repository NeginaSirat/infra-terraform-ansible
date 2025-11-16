output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "security_group_id" {
  value = aws_security_group.devops_sg.id
}

output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "nexus_public_ip" {
  value = aws_instance.nexus.public_ip
}

output "sonarqube_public_ip" {
  value = aws_instance.sonarqube.public_ip
}
