output "Nexus_LB_DNS" {
  value = aws_lb.Nexus_ALB.dns_name
}

output "target-group-arn"{
  value = aws_lb_target_group.TargetGroup.arn
}

output "zone_id"{
  value = aws_lb.Nexus_ALB.zone_id
}

