variable "security_group_name" {
  type =  string
}

variable "ingress_group_rule" {
  type = object({
    type = string,
    from_port = list(number),
    to_port = list(number),
    protocol = string,
    cidr_blocks = string
  })
}

variable "egress_group_rule" {
  type = object({
    type = string,
    from_port = list(number),
    to_port = list(number),
    protocol = string,
    cidr_blocks = string
  })
}

variable "vpc_id" {
  type = string
}