variable "env" {
  type = "string"
}

variable "alb_name" {
  type = "string"
}

variable "subnet_ids" {
  type = "list"
}

variable "alb_tg_protocol" {
  type = "string"
}

variable "alb_tg_port" {
  type = "string"
}

variable "vpc_id" {
  type = "string"
}

variable "sg_ids" {
  type = "list"
}

variable "internal" {
  type = "string"

  default = "false"
}

variable "idle_timeout" {
  type = "string"

  default = "60"
}

variable "alb_access_logs_enabled" {
  default = "false"
}

variable "alb_access_logs_prefix" {
  default = ""
}

variable "alb_access_logs_bucket" {
  default = ""
}

variable "secure_listeners_port" {
  type = "list"

  default = []
}

variable "secure_listeners_protocol" {
  type = "list"

  default = []
}

variable "secure_listener_action_type" {
  type = "string"

  default = "forward"
}

variable "listener_ssl_certificate" {
  type = "string"

  default = ""
}

variable "listener_ssl_policy" {
  type = "string"

  default = "ELBSecurityPolicy-2015-05"
}

variable "normal_listeners_port" {
  type = "list"

  default = []
}

variable "normal_listeners_protocol" {
  type = "list"

  default = []
}

variable "normal_listener_action_type" {
  type = "string"

  default = "forward"
}

variable "alb_tg_hc_interval" {
  type = "string"

  default = "30"
}

variable "alb_tg_hc_path" {
  type = "string"

  default = "/"
}

variable "alb_tg_hc_port" {
  type = "string"

  default = "80"
}

variable "alb_tg_hc_protocol" {
  type = "string"

  default = "HTTP"
}

variable "alb_tg_hc_timeout" {
  type = "string"

  default = "5"
}

variable "alb_tg_hc_healthy" {
  type = "string"

  default = "2"
}

variable "alb_tg_hc_unhealthy" {
  type = "string"

  default = "5"
}

variable "healthy_status_code" {
  type = "string"

  default = "200"
}

variable "tags" {
  type = "map"

  default = {}
}