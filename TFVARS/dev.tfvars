// VPC
P_vpc = {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = true 
}

P_vpc_name = "aws-vpc"

// SUBNET

P_public_subnet = {
  cidr_block        = ["10.0.0.0/18", "10.0.64.0/18"]
  availability_zone = ["us-east-2a", "us-east-2b"]
}
P_private_subnet = {
  cidr_block        = ["10.0.128.0/18", "10.0.192.0/18"]
  availability_zone = ["us-east-2b", "us-east-2a"]
}

P_public_subnet_name                 = ["public01", "public02"]
P_private_subnet_name                = ["private01", "private02"]
P_eip_domain ="vpc"
P_internet_gateway_name = "aws-internet-gateway"
P_nat_gateway_name= "aws-nat-gateway"
P_route_table_association_cidr_block= "0.0.0.0/0"
P_public_rout_table_name="PUBLIC-ROUTE-TABLE"
P_private_route_table_name= "PRIVATE-ROUTE-TABLE"

// SSH_KEY

P_ssh_key= {
    key_name   = "ssh-key"
    public_key = "/root/.ssh/id_rsa.pub"
}

// EC2

web_instance_name="web-instance"

web_aws_instance={
  ami = "ami-0ee4f2271a4df2d7d"
  instance_type = "t2.micro"
  associate_public_ip_address = true
}

app_instance_name="app-instance"

app_aws_instance={
  ami = "ami-0ee4f2271a4df2d7d"
  instance_type = "t2.micro"
  associate_public_ip_address = true
}

// SECURITY_GROUP

web_security_group_name="web-gs"

web_sg_ingress_rule = {
  type             = "ingress"
  from_port        = [80, 443, 22]  
  to_port          = [80, 443, 22]    
  protocol         = "tcp"  
  cidr_blocks      = "0.0.0.0/0"
}

web_sg_egress_rule = {
   type = "egress"
   from_port = [0]
   to_port = [0]
   protocol = "-1"
   cidr_blocks = "0.0.0.0/0"
}

app_security_group_name="app-sg"

app_sg_ingress_rule = {
  type             = "ingress"
  from_port        = [80, 3306, 22]
  to_port          = [80, 3306, 22]   
  protocol         = "tcp"  
  cidr_blocks      = "0.0.0.0/0"
}

app_sg_egress_rule = {
   type = "egress"
   from_port = [0]
   to_port = [0]
   protocol = "-1"
   cidr_blocks = "0.0.0.0/0"
}

// RDS

P_password = {
  length = 16
  special = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

P_rds = {
    M_allocated_storage = 10
    M_db_name = "RDS"
    M_engine = "mysql"
    M_instance_class = "db.t2.micro"
    M_username = "admin"
    M_skip_final_snapshot = true
}

P_db_sg_name = "my-db-sg"

rds_security_group_name = "rds-sg"

rds_sg_ingress_rule = {
  type             = "ingress"
  from_port        = [443]  
  to_port          = [443]  
  protocol         = "tcp"  
  cidr_blocks      = "0.0.0.0/0"   
}

rds_sg_egress_rule = {
   type = "egress"
   from_port = [0]
   to_port = [0]
   protocol = "-1"
   cidr_blocks = "0.0.0.0/0"
}

// S3

P_bucket = "sanu-s3-bucket"

// ALB

alb_security_group_name = "alb-sg"

alb_sg_ingress_rule = {
  type             = "ingress"
  from_port        = [443, 80]  
  to_port          = [443, 80]  
  protocol         = "tcp"  
  cidr_blocks      = "0.0.0.0/0"   
}

alb_sg_egress_rule = {
   type = "egress"
   from_port = [0]
   to_port = [0]
   protocol = "-1"
   cidr_blocks = "0.0.0.0/0"
}

P_alb = {
    name = "my-alb"
    load_balancer_type = "application"
}