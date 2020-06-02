
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_ecs_task_definition" "default" {
  task_definition = "${aws_ecs_task_definition.default.family}"
  depends_on = [ "aws_ecs_task_definition.default" ]

}

locals {
  prefix      = "${var.prefix}-webserver"
  common_tags = "${merge(var.common_tags, map("stack", "carriage-airflow-webserver"))}"

  # build steps
  build_step_project_name = "${local.prefix}"

//  dimensions_map = {
//    "TargetGroup"  = "${aws_alb_target_group.default.arn}"
//    "LoadBalancer" = "${aws_alb.default.arn}"
//  }
}
