variable "aws_instance" {
  type = object({
    ami                         = string,
    instance_type               = string,
    associate_public_ip_address = bool
  })
}
variable "aws_instance_name" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "security_groups" {
  type = list(any)
}

variable "iam_profile" {
  type = string
}