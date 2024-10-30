resource "aws_lb" "alb" {
  name     = "us-east-1-alb"
  internal = false
  load_balancer_type = "application"
  security_groups    = ["sg-0123456789abcdef0"]
  subnets            = ["subnet-0123456789abcdef0", "subnet-0123456789abcdef1"]

  enable_deletion_protection = false
}

resource "aws_route53_record" "primary" {
  zone_id = var.route53_zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }

  set_identifier = "us-east-1-primary"
  failover_routing_policy {
    type = "PRIMARY"
  }
}

# Health check for primary region
resource "aws_route53_health_check" "primary" {
  type          = "HTTP"
  port          = 80
  resource_path = "/health"
  fqdn          = var.domain_name
  failure_threshold = 3
  request_interval = 10
}