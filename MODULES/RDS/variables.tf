variable "M_password" {
  type = object({
    length = number,
    special = bool,
    override_special = string
  })
}

variable "M_rds" {
  type = object({
    M_allocated_storage = number,
    M_db_name = string,
    M_engine = string,
    M_instance_class = string,
    M_username = string,
    M_skip_final_snapshot = bool 
  })
}

variable "M_db_sg_name" {
  type = string
}

variable "M_db_subnet_id" {
  type = list(string)
}