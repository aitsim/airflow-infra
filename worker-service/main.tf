
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_ecs_task_definition" "default" {
  task_definition = "${aws_ecs_task_definition.default.family}"
   depends_on = [ "aws_ecs_task_definition.default" ]

}

locals {
  prefix      = "${var.prefix}-worker"
  common_tags = "${merge(var.common_tags, map("stack", "carriage-airflow-worker"))}"

  # build steps
  build_step_project_name = "${local.prefix}"

}
