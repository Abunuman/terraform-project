#Provider Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

# Resources Block

# 1. Setting up the Virtual Private Cloud (VPC)

# Creating a vpc
module "vpc" {
  source        = "../modules/VPC"
  miniproj_name  = var.miniproj_name
  vpc_cidr      = var.vpc_cidr
  pubsub1_cidr  = var.pubsub1_cidr
  pubsub2_cidr  = var.pubsub2_cidr
}

#Creating security group
module "SecGroup" {
  source = "../modules/SecurityGroup"
  vpc_id = module.vpc.vpc_id
}

module "ApplicationLoadBalancer" {
  source            = "../modules/LoadBalancer"
  Alb_name          = var.Alb_name
  TarG_name         = var.TarG_name
  port              = var.port   
  protocol          = var.protocol
  port_listener     = var.port_listener
  protocol_listener = var.protocol_listener
  SecGroup          = module.SecGroup.SecGroup
  sub_ass1          = module.vpc.sub_ass1
  sub_ass2          = module.vpc.sub_ass2
  vpc_id            = module.vpc.vpc_id
}

# provision an instance in aws console

#Instance 1 (Ubuntu)
resource "aws_instance" "Nexus-server1" {
  ami                         = "ami-00874d747dde814fa"
  instance_type               = "t2.micro"
  availability_zone           = "us-east-1a"
  key_name                    = "Terra-key"
  subnet_id                   = module.vpc.sub_ass1
  associate_public_ip_address = true
  security_groups             = [module.SecGroup.SecGroup]

  tags = {
    Name   = "Nexus-Terraform-1"
    source = "terraform"
  }

}

 

# Instance 2 (Ubuntu)
resource "aws_instance" "Nexus-server2" {
  ami                         = "ami-00874d747dde814fa"
  instance_type               = "t2.micro"
  availability_zone           = "us-east-1b"
  key_name                    = "Terra-key"
  subnet_id                   = module.vpc.sub_ass2
  associate_public_ip_address = true
  security_groups             = [module.SecGroup.SecGroup]

  tags = {
    Name   = "Nexus-Terraform-2"
    source = "terraform"
  }

}




# Instance 3 (Ubuntu)
resource "aws_instance" "Nexus-server3" {
  ami                         = "ami-00874d747dde814fa"
  instance_type               = "t2.micro"
  availability_zone           = "us-east-1a"
  key_name                    = var.ssh_key
  subnet_id                   = module.vpc.sub_ass1
  associate_public_ip_address = true
  security_groups             = [module.SecGroup.SecGroup]

  tags = {
    Name   = "Nexus-Terraform-3"
    source = "terraform"
  }
 
}
# Copying IP into host-inventory
resource "local_file" "hosts" {
content = "${aws_instance.Nexus-server1.public_ip}\n${aws_instance.Nexus-server2.public_ip}\n${aws_instance.Nexus-server3.public_ip}"
filename = "host-inventory"
}


#Attaching Instances to the target group 
resource "aws_lb_target_group_attachment" "Inst-Tag1" {
  target_group_arn = module.ApplicationLoadBalancer.target-group-arn 
  target_id        = aws_instance.Nexus-server1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "Inst-Tag2" {
  target_group_arn = module.ApplicationLoadBalancer.target-group-arn 
  target_id        = aws_instance.Nexus-server2.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "Inst-Tag3" {
  target_group_arn = module.ApplicationLoadBalancer.target-group-arn 
  target_id        = aws_instance.Nexus-server3.id
  port             = 80
}

#creating a route53 
module "route53" {
  source             = "../modules/route53"
  domain_name        = var.domain_name
  subdomain_name    = var.subdomain_name
  Nexus_LB_DNS = module.ApplicationLoadBalancer.Nexus_LB_DNS
  zone_id            = module.ApplicationLoadBalancer.zone_id
}
  