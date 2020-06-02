resource "aws_ecs_service" "default" {
  name    = "${local.prefix}-service"
  cluster = "${var.ecs_cluster["name"]}"

  #task_definition = "${aws_ecs_task_definition.default.arn}"
  task_definition = "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:task-definition/${aws_ecs_task_definition.default.family}:${max("${aws_ecs_task_definition.default.revision}", "${data.aws_ecs_task_definition.default.revision}")}"
  desired_count   = "${var.desired_count}"
  launch_type     = "EC2"

  network_configuration {
    security_groups = values(var.security_group_ids)

    subnets = var.private_subnet_ids
  }


    depends_on = [
    "aws_ecs_task_definition.default"
  ]

}
