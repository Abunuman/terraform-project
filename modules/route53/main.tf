#Creating a Route53 hosted zone
resource "aws_route53_zone" "hosted_zone" {
  name = var.domain_name
}

#create "A" record inside the hosted zone 
resource "aws_route53_record" "A-record" {
  zone_id = aws_route53_zone.hosted_zone.zone_id
  name    = var.subdomain_name
  type    = "A"

  alias {
    name                   = var.Nexus_LB_DNS
    zone_id                = var.zone_id
    evaluate_target_health = true
  }
}