data "aws_iam_policy_document" "builds_bucket_access_policy_document" {
  statement {
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.builds_bucket.arn}/*"]
  }
}

data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "builds_bucket_access_policy" {
  name        = "build-bucket-access"
  description = "Policy to allow access to the builds bucket"
  policy      = "${data.aws_iam_policy_document.builds_bucket_access_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "build_bucket_attach" {
  role       = "${aws_iam_role.build_agent_role.name}"
  policy_arn = "${aws_iam_policy.builds_bucket_access_policy.arn}"
}

resource "aws_iam_role" "build_agent_role" {
  name               = "build-agent-role"
  assume_role_policy = "${data.aws_iam_policy_document.instance-assume-role-policy.json}"
}

resource "aws_iam_instance_profile" "build_agent_profile" {
  name = "build-agent-profile"
  role = "${aws_iam_role.build_agent_role.name}"
}
