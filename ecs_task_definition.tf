resource "aws_ecs_task_definition" "migration" {
  family                   = "${local.prefix}-migrate"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "${var.ecs_migrate_config["fargate_cpu"]}"
  memory                   = "${var.ecs_migrate_config["fargate_memory"]}"
  task_role_arn            = "${module.airflow_webserver.role_arn}"
  execution_role_arn       = "${module.airflow_webserver.role_arn}"

  container_definitions = <<DEFINITION
[
  {
    "cpu": ${var.ecs_migrate_config["fargate_cpu"]},
    "image": "${aws_ecr_repository.default.repository_url}:${var.common_tags["env"]}",
    "memory": ${var.ecs_migrate_config["fargate_memory"]},
    "name": "migrate",
    "networkMode": "awsvpc",
    "command": [
      "/bin/sh",
      "-c",
      "airflow initdb"
    ],
    "environment": [
       {
        "name": "AIRFLOW__CORE__SQL_ALCHEMY_CONN",
        "value":  "${var.secrets["air_core_sql_conn"]}"
      },
      {
        "name": "AIRFLOW__CORE__EXECUTOR",
        "value" : "CeleryExecutor"
      },
      {
        "name": "AIRFLOW__CORE__LOAD_EXAMPLES",
        "value": "false"
      },
      {
        "name": "AIRFLOW__CORE__FERNET_KEY",
        "value": "${var.secrets["fernet_key"]}"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${aws_cloudwatch_log_group.migrate.name}",
        "awslogs-region": "${data.aws_region.current.name}",
        "awslogs-stream-prefix": "${var.prefix}-"
      }
    }
  }
]
DEFINITION
}
