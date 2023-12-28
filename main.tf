// VPC

module "vpc" {
  source = "./MODULES/VPC"
  vpc = var.P_vpc
  vpc_name = var.P_vpc_name
  nat_gateway_name = var.P_nat_gateway_name
  eip_domain = var.P_eip_domain
  internet_gateway_name = var.P_internet_gateway_name
  route_table_association_cidr_block = var.P_route_table_association_cidr_block
  public_rout_table_name = var.P_public_rout_table_name
  private_route_table_name = var.P_private_route_table_name
  private_subnet = var.P_private_subnet
  public_subnet = var.P_public_subnet
  public_subnet_name = var.P_public_subnet_name
  private_subnet_name = var.P_private_subnet_name
}

// SSH_KEY

module "aws_key_pair" {
  source = "./MODULES/SSH_KEY"
  ssh_key = var.P_ssh_key
}

// WEB SERVER

module "web_sg" {
  source = "./MODULES/SECURITY_GROUP"
  security_group_name = var.web_security_group_name
  ingress_group_rule = var.web_sg_ingress_rule
  egress_group_rule = var.web_sg_egress_rule
  vpc_id = module.vpc.vpc_id
}

module "web_instance" {
  source = "./MODULES/EC2"
  aws_instance = var.web_aws_instance
  aws_instance_name = var.web_instance_name
  public_subnet_id =  module.vpc.public_subnet_id[0]
  key_name = module.aws_key_pair.ssh_key_name 
  security_groups = [module.web_sg.SECURITY_GROUP]
}

// APP SERVER

module "app_sg" {
  source = "./MODULES/SECURITY_GROUP"
  security_group_name = var.app_security_group_name 
  ingress_group_rule = var.app_sg_ingress_rule
  egress_group_rule = var.app_sg_egress_rule 
  vpc_id = module.vpc.vpc_id
}

module "app_instance" {
  source = "./MODULES/EC2"
  aws_instance = var.web_aws_instance
  aws_instance_name = var.web_instance_name
  public_subnet_id =  module.vpc.private_subnet_id[0]
  key_name = module.aws_key_pair.ssh_key_name 
  security_groups = [module.app_sg.SECURITY_GROUP]
}

// RDS

module "rds" {
  source = "./MODULES/RDS"
  M_rds = var.P_rds 
  M_password = var.P_password
  M_db_sg_name = var.P_db_sg_name
  M_db_subnet_id = module.vpc.private_subnet_id[*]
}

module "rds_sg" {
  source = "./MODULES/SECURITY_GROUP"
  security_group_name = var.rds_security_group_name
  ingress_group_rule = var.rds_sg_ingress_rule
  egress_group_rule = var.rds_sg_egress_rule
  vpc_id = module.vpc.vpc_id
}

// S3

module "S3_bucket" {
  source = "./MODULES/S3"
  bucket = var.P_bucket
}

// ALB

module "this_alb" {
  source = "./MODULES/ALB"
  alb = var.P_alb
  alb_public_subnet = module.vpc.public_subnet_id[*]
  alb_security_group = module.alb_sg.SECURITY_GROUP
}

module "alb_sg" {
  source = "./MODULES/SECURITY_GROUP"
  security_group_name = var.alb_security_group_name
  ingress_group_rule = var.alb_sg_ingress_rule
  egress_group_rule = var.alb_sg_egress_rule
  vpc_id = module.vpc.vpc_id
}