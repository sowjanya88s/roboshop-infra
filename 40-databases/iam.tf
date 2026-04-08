resource "aws_iam_role" "mysql_role" {
  name = "mysql_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "${var.project}-${var.environment}-mysql"
  }
}

resource "aws_iam_role_policy_attachment" "mysql-attach" {
  role       = aws_iam_role.mysql_role.name
  policy_arn = aws_iam_policy.policy.arn
}
resource "aws_iam_instance_profile" "mysql_profile" {
  name = "mysql_profile"
  role = aws_iam_role.mysql_role.name
}