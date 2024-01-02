// VPC
variable "P_vpc" {
  type = object({
    cidr_block = string,
    instance_tenancy = string,
    enable_dns_hostnames = bool
  })
}

variable "P_vpc_name" {
  type = string 
}

// SUBNET

variable "P_public_subnet" {
  type = object({
    cidr_block        = list(string),
    availability_zone = list(string)
  })
}
variable "P_public_subnet_name" {
  type = list(any)
}
variable "P_private_subnet" {
  type = object({
    cidr_block        = list(string),
    availability_zone = list(string)
  })
}
variable "P_private_subnet_name" {
  type = list(any)
}

variable "P_eip_domain" {
  type = string
}

variable "P_internet_gateway_name" {
  type = string
}

variable "P_nat_gateway_name" {
  type = string
}

variable "P_route_table_association_cidr_block" {
  type = string
}

variable "P_public_rout_table_name" {
  type = string
}
variable "P_private_route_table_name" {
  type = string
}

// SSH

variable "P_ssh_key" {
  type = object({
    key_name   = string,
    public_key = string
  })
}

// EC2

variable "web_aws_instance" {
  type = object({
    ami                         = string,
    instance_type               = string,
    associate_public_ip_address = bool
  })
}
variable "web_instance_name" {
  type = string
}

variable "app_aws_instance" {
  type = object({
    ami                         = string,
    instance_type               = string,
    associate_public_ip_address = bool
  })
}

variable "app_instance_name" {
  type = string
}

######## FOR WEB ########

variable "web_security_group_name" {
  type = string
}

variable "web_sg_ingress_rule" {
  type = object({
    type = string,
    from_port = list(string),
    to_port = list(string),
    protocol = string,
    cidr_blocks = string
  })
}

variable "web_sg_egress_rule" {
  type = object({
    type = string,
    from_port = list(number),
    to_port = list(number),
    protocol = string,
    cidr_blocks = string
  })
}

######## FOR APP ########

variable "app_security_group_name" {
  type = string
}

variable "app_sg_ingress_rule" {
  type = object({
    type = string,
    from_port = list(number),
    to_port = list(number),
    protocol = string,
    cidr_blocks = string
  })
}

variable "app_sg_egress_rule" {
  type = object({
    type = string,
    from_port = list(number),
    to_port = list(number),
    protocol = string,
    cidr_blocks = string
  })
}

// RDS

variable "P_password" {
  type = object({
    length = number,
    special = bool,
    override_special = string
  })
}

variable "P_rds" {
  type = object({
    M_allocated_storage = number,
    M_db_name = string,
    M_engine = string,
    M_instance_class = string,
    M_username = string,
    M_skip_final_snapshot = bool
  })
}

variable "P_db_sg_name" {
  type = string
}

variable "rds_security_group_name" {
  type = string
}

variable "rds_sg_ingress_rule" {
  type = object({
    type = string,
    from_port = list(number),
    to_port = list(number),
    protocol = string,
    cidr_blocks = string
  })
}

variable "rds_sg_egress_rule" {
  type = object({
    type = string,
    from_port = list(number),
    to_port = list(number),
    protocol = string,
    cidr_blocks = string
  })
}

variable "P_parameter" {
  type = object({
    name = string
    type = string
  })
}

// S3

variable "P_bucket" {
  type = string
}

// ALB

variable "P_alb" {
  type = object({
    name = string,
    load_balancer_type = string
  })
}

variable "alb_security_group_name" {
  type = string
}

variable "alb_sg_ingress_rule" {
  type = object({
    type = string,
    from_port = list(number),
    to_port = list(number),
    protocol = string,
    cidr_blocks = string
  })
}

variable "alb_sg_egress_rule" {
  type = object({
    type = string,
    from_port = list(number),
    to_port = list(number),
    protocol = string,
    cidr_blocks = string
  })
}