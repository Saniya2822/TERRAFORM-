variable "alb" {
  type = object({
    name = string,
    load_balancer_type = string
  })
}

variable "alb_security_group" {
  type = string
}

variable "alb_public_subnet" {
  type = list(string)
}