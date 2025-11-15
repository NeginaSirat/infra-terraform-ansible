output "app_public_ip" {
  description = "Public IP of the demo EC2 instance"
  value       = aws_instance.app.public_ip
}
