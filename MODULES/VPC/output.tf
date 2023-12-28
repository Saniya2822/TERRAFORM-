output "public_subnet_id" {
  value = aws_subnet.this_public_subnet[*].id
}

output "private_subnet_id" {
  value = aws_subnet.this_private_subnet[*].id
}

output "vpc_id" {
  value = aws_vpc.this_vpc.id 
}