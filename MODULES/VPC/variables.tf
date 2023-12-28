// VPC
variable "vpc" {
  type = object({
    cidr_block = string,
    instance_tenancy = string,
    enable_dns_hostnames = bool
  })
}

variable "vpc_name" {
  type = string 
}

// SUBNET

variable "public_subnet" {
  type = object({
    cidr_block        = list(any),
    availability_zone = list(any)
  })
}
variable "public_subnet_name" {
  type = list(any)
}
variable "private_subnet" {
  type = object({
    cidr_block        = list(any),
    availability_zone = list(any)
  })
}
variable "private_subnet_name" {
  type = list(any)
}

variable "eip_domain" {
  type = string
}

variable "internet_gateway_name" {
  type = string
}

variable "nat_gateway_name" {
  type = string
}

variable "route_table_association_cidr_block" {
  type = string
}

variable "public_rout_table_name" {
  type = string
}
variable "private_route_table_name" {
  type = string
}