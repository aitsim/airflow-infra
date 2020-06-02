variable "prefix" {}

variable "common_tags" {
  type = "map"
}

variable "kms_arn" {}

# s3 buckets
variable "s3_logging" {
  type = "map"
}

variable "s3_settings" {
  type = "map"
}
variable "s3_data_lake" {
  type = "map"
}

variable "ecs_cluster" {
  type = "map"
}

# ecs fargate
variable "ecs_webserver_config" {
  type = "map"
}

variable "ecs_worker_config" {
  type = "map"
}

variable "ecs_migrate_config" {
  type = "map"
}

variable "ecs_scheduler_config" {
  type = "map"
}

# network
variable "public_subnet_ids" {
  type = "list"
}

variable "private_subnet_ids" {
  type = "list"
}

variable "vpc_id" {}

variable "security_group_ids" {
  type = "map"
}

# secret
variable "secrets" {
  type = "map"

  description = <<EOF
  Accepts a map e.g:

    secrets = {


      AIRFLOW__CORE__SQL_ALCHEMY_CONN=""


    }
EOF
}


variable "gh_token" {}
variable "gh_repo" {}

variable "gh_org" {}

variable "pipe_webhook" {
  type = "map"
}

variable "s3_artifacts" {}
variable "s3_cache" {}


variable "adm_cidr" {}
variable "cidr_block" {}