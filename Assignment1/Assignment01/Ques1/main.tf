resource "aws_iam_user" "my_user" {
  name = var.name[0]
  path = "/"

  tags = {
    tag-key = "SANIYA"
  }
}

resource "aws_iam_group" "developers" {
  name = var.name[1]
  path = "/"
}