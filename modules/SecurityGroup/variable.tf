variable "traffic_ingress" {
  type = map(object({
    description = string
    port        = number
    protocol    = string
    cidr        = list(string)
  }))

  default = {
    "80" = {
      description = "HTTP inbound traffic"
      port        = 80
      protocol    = "tcp"
      cidr        = ["0.0.0.0/0"]
    }

    "443" = {
      description = "HTTPS inound traffic"
      port        = 443
      protocol    = "tcp"
      cidr        = ["0.0.0.0/0"]
    }

    "22" = {
      description = "Allow SSH traffic"
      port        = 22
      protocol    = "tcp"
      cidr        = ["0.0.0.0/0"]
    }
  }
}

variable "vpc_id"{}