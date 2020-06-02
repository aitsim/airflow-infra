
data "aws_region" "current" {}

locals {
  prefix      = "${var.prefix}"
  common_tags = "${merge(var.common_tags)}"

  # build steps
  build_step_project_name = "${local.prefix}"
}
