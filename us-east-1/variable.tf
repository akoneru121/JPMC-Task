# variables.tf

variable "primary_region" {
  description = "Primary AWS region"
  type        = string
  default     = "us-east-1"
}

variable "secondary_region" {
  description = "Secondary AWS region"
  type        = string
  default     = "us-west-2"
}

variable "instance_type" {
  description = "EC2 instance type for Tomcat server"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for Tomcat compatible instance"
  type        = string
  default     = "ami-06b21ccaeff8cd686" # Update with your AMI ID
}

variable "domain_name" {
  description = "The domain name for Route 53"
  type        = string
}

variable "route53_zone_id" {
  description = "Route 53 Zone ID"
  type        = string
}



