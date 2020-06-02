resource "aws_security_group" "default" {
  name        = "${local.prefix}-sg"
  description = "${local.prefix} node ECS service"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port       = "${var.worker_port}"
    protocol        = "TCP"
    to_port         = "${var.worker_port}"
    cidr_blocks = [var.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.common_tags, map("Name", "${local.prefix}-sg"))}"
}