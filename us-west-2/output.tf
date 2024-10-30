# Primary EC2 Instance Public IP
output "secondary_instance_ip" {
  description = "Public IP of the primary EC2 instance"
  value       = aws_instance.secondary_instance.public_ip
}