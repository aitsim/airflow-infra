
output "role_arn" {
  value = "${aws_iam_role.role.arn}"
}

output "ecs_service_name" {
  value = "${aws_ecs_service.default.name}"
}

output "ecs_task_def" {
  value = "${aws_ecs_task_definition.default.family}:${aws_ecs_task_definition.default.revision}"
}

output "cloudwatch_log_group" {
  value = "${aws_cloudwatch_log_group.ecs.name}"
}