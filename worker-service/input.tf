variable "prefix" {}

variable "common_tags" {
  type = "map"
}

variable "kms_arn" {}

variable "ecs_cluster" {
  type = "map"
}

variable "container_name" {}
variable "ecr_repository_url" {}

# ecs fargate
variable "fargate_cpu" {
  default = 256
}

variable "fargate_memory" {
  default = 512
}

variable "desired_count" {
  default = 1
}

variable "worker_port" {
  default = 8793
}
variable "cidr_block" {}

# network
variable "public_subnet_ids" {
  type = "list"
}

variable "private_subnet_ids" {
  type = "list"
}
# s3 buckets
variable "s3_settings" {
  type = "map"
}
variable "s3_logging" {
  type = "map"
}
variable "s3_data_lake" {
  type = "map"
}
variable "security_group_ids" {
  type = "map"
}

variable "vpc_id" {}


variable "secrets" {
  type = map(string)
}
