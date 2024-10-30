# Primary EC2 Instance Public IP
output "primary_instance_ip" {
  description = "Public IP of the primary EC2 instance"
  value       = aws_instance.primary_instance.public_ip
}

