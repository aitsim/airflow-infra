data "aws_iam_policy_document" "policy" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "*",
    ]
  }
  statement {

    actions = [
      "kms:*",
    ]
    effect = "Allow"
    resources = [
      "${var.kms_arn}",
    ]
  }

    statement {
    actions = ["s3:*"]

    resources = [
      "${var.s3_settings["arn"]}",
      "${var.s3_settings["arn"]}/*",
      "${var.s3_logging["arn"]}",
      "${var.s3_logging["arn"]}/*",
      "${var.s3_data_lake["arn"]}",
      "${var.s3_data_lake["arn"]}/*",
    ]
  }


}

data "aws_iam_policy_document" "assume" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "ecs-tasks.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_policy" "policy" {
  name   = "${local.prefix}-policy"
  path   = "/"
  policy = "${data.aws_iam_policy_document.policy.json}"
}

resource "aws_iam_role" "role" {
  name               = "${local.prefix}-role"
  assume_role_policy = "${data.aws_iam_policy_document.assume.json}"
  description        = "${local.prefix}"
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  policy_arn = "${aws_iam_policy.policy.arn}"
  role       = "${aws_iam_role.role.name}"
}

resource "aws_iam_instance_profile" "profile" {
  name = "${local.prefix}-profile"
  role = "${aws_iam_role.role.name}"
}
