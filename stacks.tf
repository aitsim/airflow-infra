module "airflow_webserver" {
  source = "./webserver-service"

  prefix = local.prefix
  common_tags = local.common_tags

  # ecs
  container_name = "webserver"
  ecs_cluster = var.ecs_cluster
  app_port = var.ecs_webserver_config["port"]
  fargate_cpu = var.ecs_webserver_config["fargate_cpu"]
  fargate_memory = var.ecs_webserver_config["fargate_memory"]
  desired_count = var.ecs_webserver_config["desired_count"]

  # network
  vpc_id = var.vpc_id
  private_subnet_ids = var.private_subnet_ids
  public_subnet_ids = var.public_subnet_ids
  security_group_ids = var.security_group_ids

  kms_arn = var.kms_arn

  #s3
  s3_settings = var.s3_settings
  s3_logging = var.s3_logging
  s3_data_lake = var.s3_data_lake
  ecr_repository_url = aws_ecr_repository.default.repository_url

  secrets = var.secrets
  adm_cidr = var.adm_cidr

}


module "airflow_scheduler" {
  source = "./scheduler-service"

  prefix = local.prefix
  common_tags = local.common_tags

  # ecs
  container_name = "scheduler"
  ecs_cluster = var.ecs_cluster
  fargate_cpu = var.ecs_scheduler_config["fargate_cpu"]
  fargate_memory = var.ecs_scheduler_config["fargate_memory"]
  desired_count = var.ecs_scheduler_config["desired_count"]

  # network
  vpc_id = var.vpc_id
  private_subnet_ids = var.private_subnet_ids
  public_subnet_ids = var.public_subnet_ids
  security_group_ids = var.security_group_ids

  kms_arn = var.kms_arn

  #s3
  s3_settings = var.s3_settings
  s3_logging = var.s3_logging
  s3_data_lake = var.s3_data_lake
  ecr_repository_url = aws_ecr_repository.default.repository_url


  secrets = var.secrets
}


module "airflow_worker" {
  source = "./worker-service"

  prefix = local.prefix
  common_tags = local.common_tags

  # ecs
  container_name = "worker"
  ecs_cluster = var.ecs_cluster
  fargate_cpu = var.ecs_worker_config["fargate_cpu"]
  fargate_memory = var.ecs_worker_config["fargate_memory"]
  desired_count = var.ecs_worker_config["desired_count"]

  # network
  vpc_id = var.vpc_id
  private_subnet_ids = var.private_subnet_ids
  public_subnet_ids = var.public_subnet_ids
  security_group_ids = var.security_group_ids

  kms_arn = var.kms_arn

  #s3
  s3_settings = var.s3_settings
  s3_logging = var.s3_logging
  s3_data_lake = var.s3_data_lake
  ecr_repository_url = aws_ecr_repository.default.repository_url

  secrets = var.secrets
  cidr_block = var.cidr_block

}


module "ci_pipeline" {
  source      = "./ci-pipeline"
  prefix      = local.prefix
  common_tags = local.common_tags

  kms_arn = var.kms_arn

  # ecs
  ecs_task_migrate = aws_ecs_task_definition.migration.family

  # pipeline env
  gh_token       = var.gh_token
  gh_repo        = var.gh_repo
  gh_org         = var.gh_org
  repository_uri = aws_ecr_repository.default.repository_url

  # network
  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids
  security_group_ids = var.security_group_ids

  # s3 buckets
  s3_artifacts = var.s3_artifacts
  s3_settings= var.s3_settings
  s3_cache     = var.s3_cache

  ecs_cluster = var.ecs_cluster

  ecs_services_names = {
    webserver       = module.airflow_webserver.ecs_service_name
    scheduler       = module.airflow_scheduler.ecs_service_name
    worker          = module.airflow_worker.ecs_service_name


  }

  migrate_sg_ids = var.security_group_ids
  pipe_webhook   = var.pipe_webhook
}
