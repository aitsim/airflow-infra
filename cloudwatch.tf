resource "aws_cloudwatch_log_group" "migrate" {
  name              = "/aws/ecs/${local.prefix}-migrate"
  retention_in_days = 30

  tags = "${local.common_tags}"
}
