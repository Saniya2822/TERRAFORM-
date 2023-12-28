resource "aws_security_group" "this_security_group" {
  name        = var.security_group_name
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "this_ingress" {
  count= length(var.ingress_group_rule.from_port)
  type              = var.ingress_group_rule.type
  from_port         = var.ingress_group_rule.from_port[count.index]
  to_port           = var.ingress_group_rule.to_port[count.index]
  protocol          = var.ingress_group_rule.protocol
  cidr_blocks       = [var.ingress_group_rule.cidr_blocks]
  security_group_id = aws_security_group.this_security_group.id
}

resource "aws_security_group_rule" "this_egress" {
  count= length(var.egress_group_rule.from_port)
  type              = var.egress_group_rule.type
  from_port         = var.egress_group_rule.from_port[count.index]
  to_port           = var.egress_group_rule.to_port[count.index]
  protocol          = var.egress_group_rule.protocol
  cidr_blocks       = [var.egress_group_rule.cidr_blocks]
  security_group_id = aws_security_group.this_security_group.id
}
