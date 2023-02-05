
variable "vpc_cidr" {}
variable "miniproj_name" {}
variable "pubsub1_cidr" {}
variable "pubsub2_cidr" {}

#Variables for Security Group

variable "traffic_ingress" {
  type = map(object({
    description = string
    port        = number
    protocol    = string
    cidr        = list(string)
  }))

  default = {
    "80" = {
      description = "HTTP traffic"
      port        = 80
      protocol    = "tcp"
      cidr        = ["0.0.0.0/0"]
    }

    "443" = {
      description = "HTTPS traffic"
      port        = 443
      protocol    = "tcp"
      cidr        = ["0.0.0.0/0"]
    }

    "22" = {
      description = "SSH traffic"
      port        = 22
      protocol    = "tcp"
      cidr        = ["0.0.0.0/0"]
    }
  }
}

# Variables for Application Load Balancer 
variable "Alb_name" {
  type = string
}

variable "TarG_name" {
  type = string
}

variable "port" {
  type = number
}

variable "protocol" {
  type = string
}

variable "health_check" {
  type = map(string)
  default = {
    "interval"            = "300"
    "path"                = "/"
    "timeout"             = "60"
    "matcher"             = "200"
    "healthy_threshold"   = "5"
    "unhealthy_threshold" = "5"
  }
}

variable "port_listener" {
  type = string
}
variable "protocol_listener" {
  type = string
}

#Variable for SSH Key

variable "ssh_key" {
  description = "SSH Key name"
  type = string
}

# Variables for Route 53
variable "domain_name" {
  description = "Describes the domain name"
  type = string
}
variable "subdomain_name" {
  description = "Describes the subdomain name"
  type = string
}
