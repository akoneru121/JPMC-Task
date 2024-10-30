resource "aws_lb" "alb" {
  name     = "us-west-2-alb"
  internal = false
  load_balancer_type = "application"
  security_groups    = ["sg-0123456789abcdef0"]
  subnets            = ["subnet-0123456789abcdef2", "subnet-0123456789abcdef3"]

  enable_deletion_protection = false
}

resource "aws_route53_record" "secondary" {
  zone_id = var.route53_zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }

  set_identifier = "us-west-2-secondary"
  failover_routing_policy {
    type = "SECONDARY"
  }
}

# Health check for secondary region
resource "aws_route53_health_check" "secondary" {
  type          = "HTTP"
  port          = 80
  resource_path = "/health"
  fqdn          = var.domain_name
  failure_threshold = 3
  request_interval = 10
}