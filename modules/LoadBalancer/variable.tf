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

variable "SecGroup"{}
variable "sub_ass1"{}
variable "sub_ass2"{}
variable "vpc_id"{}