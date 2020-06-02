output "node_dns_name" {
  value = "${aws_alb.default.dns_name}"

}

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

output "elb_zone_id" {
  value = aws_alb.default.zone_id
}