resource "aws_ecs_service" "default" {
  name    = "${local.prefix}-service"
  cluster = "${var.ecs_cluster["name"]}"

  #task_definition = "${aws_ecs_task_definition.default.arn}"
  task_definition = "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:task-definition/${aws_ecs_task_definition.default.family}:${max("${aws_ecs_task_definition.default.revision}", "${data.aws_ecs_task_definition.default.revision}")}"
  desired_count   = "${var.desired_count}"
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = concat(values(var.security_group_ids), [aws_security_group.default.id, ])

    subnets = var.private_subnet_ids

  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.default.arn}"
    container_name   = "${var.container_name}"
    container_port   = "${var.app_port}"
  }

  depends_on = [
    "aws_alb_listener.default",
    "aws_ecs_task_definition.default"
  ]
}
