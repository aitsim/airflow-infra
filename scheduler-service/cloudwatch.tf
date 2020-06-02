resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/aws/ecs/${local.prefix}"
  retention_in_days = 30

  tags = "${local.common_tags}"
}