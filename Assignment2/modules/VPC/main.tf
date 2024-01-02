// VPC

resource "aws_vpc" "this_vpc" {
  cidr_block           = var.vpc.cidr_block
  instance_tenancy     = var.vpc.instance_tenancy
  enable_dns_hostnames = var.vpc.enable_dns_hostnames

  tags = {
    Name = var.vpc_name
  }
}

// SUBNET 

resource "aws_subnet" "this_public_subnet" {
  count             = length(var.public_subnet.cidr_block)
  vpc_id            = aws_vpc.this_vpc.id
  cidr_block        = var.public_subnet.cidr_block[count.index]
  availability_zone = var.public_subnet.availability_zone[count.index]
  tags = {
    Name = "${var.public_subnet_name[count.index]}_${count.index + 1}"
  }
}
resource "aws_subnet" "this_private_subnet" {
  count             = length(var.private_subnet.cidr_block)
  vpc_id            = aws_vpc.this_vpc.id
  cidr_block        = var.private_subnet.cidr_block[count.index]
  availability_zone = var.private_subnet.availability_zone[count.index]
  tags = {
    Name = "${var.private_subnet_name[count.index]}_${count.index + 1}"
  }
}

// ELASTIC IP
resource "aws_eip" "this_eip" {
  domain = var.eip_domain
}

// INTERNET GATEWAY
resource "aws_internet_gateway" "this_igw" {
  vpc_id = aws_vpc.this_vpc.id
  tags = {
    Name = var.internet_gateway_name
  }
}

// NAT GATEWAY
resource "aws_nat_gateway" "this_nat_gw" {
  allocation_id = aws_eip.this_eip.id
  subnet_id     = aws_subnet.this_public_subnet[0].id
  tags = {
    Name = var.nat_gateway_name
  }
}

// ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "this_pub_sub_asso" {
  count          = length(var.public_subnet.cidr_block)
  subnet_id      = aws_subnet.this_public_subnet[count.index].id
  route_table_id = aws_route_table.this_pub_rot_tab.id
}

resource "aws_route_table_association" "this_pri_sub_asso" {
  count          = length(var.private_subnet.cidr_block)
  subnet_id      = aws_subnet.this_private_subnet[count.index].id
  route_table_id = aws_route_table.this_pri_rot_tab.id
}

// ROUTE TABLE
resource "aws_route_table" "this_pub_rot_tab" {
  vpc_id = aws_vpc.this_vpc.id
  route {
    cidr_block = var.route_table_association_cidr_block
    gateway_id = aws_internet_gateway.this_igw.id
  }
  tags = {
    Name = var.public_rout_table_name
  }
}
resource "aws_route_table" "this_pri_rot_tab" {
  vpc_id = aws_vpc.this_vpc.id
  route {
    cidr_block     = var.route_table_association_cidr_block
    nat_gateway_id = aws_nat_gateway.this_nat_gw.id
  }
  tags = {
    Name = var.private_route_table_name
  }
}