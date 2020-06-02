resource "aws_alb" "default" {
  name            = local.prefix
  subnets         = var.private_subnet_ids
  security_groups = ["${aws_security_group.default_alb.id}", "${var.security_group_ids["default_vpc"]}"]
  internal        = true
  tags            = merge(local.common_tags, map("Name", "${local.prefix}-alb"))

  access_logs {
    bucket  = var.s3_logging["bucket"]
    prefix  = "alb/${local.prefix}"
    enabled = true
  }
}



resource "aws_alb_target_group" "default" {
  name        = "${local.prefix}"
  port        = "${var.app_port}"
  protocol    = "HTTP"
  vpc_id      = "${var.vpc_id}"
  target_type = "ip"

  health_check {
    path     = "/admin/"
    protocol = "HTTP"
    port     = "${var.app_port}"
    matcher  = "200"
  }

  tags = "${merge(local.common_tags, map("Name", "${local.prefix}-tg"))}"

  depends_on = ["aws_alb.default"]
}


resource "aws_alb_listener" "default" {
  load_balancer_arn = "${aws_alb.default.id}"

  port            = 80
  protocol        = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.default.id}"
    type             = "forward"
  }
    depends_on = ["aws_alb.default","aws_alb_target_group.default"]


}