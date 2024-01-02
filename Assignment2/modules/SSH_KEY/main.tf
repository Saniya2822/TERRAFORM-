// key pair
resource "aws_key_pair" "this_ssh_key" {
  key_name   = var.ssh_key.key_name
  public_key = file(var.ssh_key.public_key)
}