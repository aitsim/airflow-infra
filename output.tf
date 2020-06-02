output "dns_names" {
  value = {
    webserver     = "${module.airflow_webserver.node_dns_name}"
  }
}


output "elb_zone_id" {
  value = module.airflow_webserver.elb_zone_id
}

output "service_names" {
  value = {
    scheduler     = "${module.airflow_scheduler.ecs_service_name}"
  }
}
