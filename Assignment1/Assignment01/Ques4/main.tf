####################
# VPC
####################

resource "aws_vpc" "data" {
  cidr_block = "10.0.0.0/16"
}

// Subnets
resource "aws_subnet" "public01" {
  vpc_id            = aws_vpc.data.id
  cidr_block        = var.cidr_block[0]
  availability_zone = var.availability_zone[0]

  tags = {
    Name = "pub_1"
  }
}

resource "aws_subnet" "public02" {
  vpc_id            = aws_vpc.data.id 
  cidr_block        = var.cidr_block[1]
  availability_zone = var.availability_zone[1]

  tags = {
    Name = "pub_2"
  }
}

resource "aws_subnet" "private01" {
  vpc_id            = aws_vpc.data.id 
  cidr_block        = var.cidr_block[2]
  availability_zone = var.availability_zone[1]

  tags = {
    Name = "pri_1"
  }
}

resource "aws_subnet" "private02" {
  vpc_id            = aws_vpc.data.id 
  cidr_block        = var.cidr_block[3]
  availability_zone = var.availability_zone[0]

  tags = {
    Name = "pri_2"
  }
}

// INTERNET GATEWAY

resource "aws_internet_gateway" "AWS_igw" {
  vpc_id = aws_vpc.data.id 
}

// Route Table

resource "aws_route_table" "pub_rot_tab" {
  vpc_id = aws_vpc.data.id 

  tags = {
    Name = "PUB_ROUT_TAB"
  }
}

resource "aws_route_table" "pri_rot_tab" {
  vpc_id = aws_vpc.data.id 

  tags = {
    Name = "PRI_ROUT_TAB"
  }
}

// Route

resource "aws_route" "pub_route" {
  route_table_id         = aws_route_table.pub_rot_tab.id
  gateway_id =  aws_internet_gateway.AWS_igw.id 
  destination_cidr_block = var.destination_cidr_block
}

resource "aws_route" "pri_route" {
  route_table_id         = aws_route_table.pri_rot_tab.id
  gateway_id             = aws_nat_gateway.aws_nat.id
  destination_cidr_block = var.destination_cidr_block
}

//Route Table Associate

resource "aws_route_table_association" "pub_rot_aso2" {
  subnet_id      = aws_subnet.public01.id 
  route_table_id = aws_route_table.pub_rot_tab.id 
}

resource "aws_route_table_association" "pri_rot_aso1" {
  subnet_id      = aws_subnet.private01.id
  route_table_id = aws_route_table.pri_rot_tab.id 
}

// NAT GATEWAY

resource "aws_nat_gateway" "aws_nat" {
  allocation_id = aws_eip.aws_eip.id 
  subnet_id     = aws_subnet.public01.id
}

//EIP

resource "aws_eip" "aws_eip" {
  domain = var.domain
}

// EC2 Instance

resource "aws_key_pair" "aws_3" {
  key_name   = var.key_name
  public_key = file("/root/.ssh/id_rsa.pub")
}

resource "aws_security_group" "aws_sg" {
  name        = "AWS-INSTANCE-SG"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.data.id 

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "AWS_INSTANCE" {
  ami                  = var.ami
  instance_type        = var.instance_type
  subnet_id            = aws_subnet.public01.id
  key_name             = aws_key_pair.aws_3.key_name
  associate_public_ip_address = true
  security_groups      = [aws_security_group.aws_sg.id]

   tags = {
    Name = "AWS_INSTANCE"
  }
}