resource "aws_db_instance" "RDS" {
  allocated_storage    = var.M_rds.M_allocated_storage
  db_name              = var.M_rds.M_db_name
  engine               = var.M_rds.M_engine
  instance_class       = var.M_rds.M_instance_class
  username             = var.M_rds.M_username
  password             = random_password.password.result
  skip_final_snapshot  = var.M_rds.M_skip_final_snapshot
  db_subnet_group_name = aws_db_subnet_group.db_sg.name
  vpc_security_group_ids = var.M_security_group_ids
}

resource "random_password" "password" {
  length           = var.M_password.length
  special          = var.M_password.special
  override_special = var.M_password.override_special
}

resource "aws_db_subnet_group" "db_sg" {
  name       = var.M_db_sg_name
  subnet_ids = var.M_db_subnet_id
}

resource "aws_ssm_parameter" "this_ssm_parameter" {
  name = var.parameter.name
  type = var.parameter.type
  value = random_password.password.result
}