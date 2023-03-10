#Creating a load balancer 
resource "aws_lb" "Nexus_ALB" {
  name                       = var.Alb_name
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.SecGroup]
  subnets                    = [var.sub_ass1, var.sub_ass2]
  enable_deletion_protection = false

  tags = {
    Name = "Nexus-Server"
  }
}

#Creating a target group
resource "aws_lb_target_group" "TargetGroup" {
  name        = var.TarG_name
  target_type = "instance"
  port        = var.port
  protocol    = var.protocol
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    interval            = var.health_check["interval"]
    path                = var.health_check["path"]
    timeout             = var.health_check["timeout"]
    matcher             = var.health_check["matcher"]
    healthy_threshold   = var.health_check["healthy_threshold"]
    unhealthy_threshold = var.health_check["unhealthy_threshold"]
  }
}


# # Add a listener
resource "aws_lb_listener" "MyListener" {
  load_balancer_arn = aws_lb.Nexus_ALB.arn
  port              = var.port_listener
  protocol          = var.protocol_listener

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TargetGroup.arn
  }
}
