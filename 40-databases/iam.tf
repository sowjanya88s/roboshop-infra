resource "aws_iam_role" "mysql_role" {
  name = "${var.project}-${var.environment}-mysql"

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

resource "aws_iam_policy" "mysql" {
  name        = "${var.project}-${var.environment}-mysql"
  description = "A policy for MySQL Ec2 instance"
   policy      = file("policies.json")
}

resource "aws_iam_role_policy_attachment" "mysql" {
  role       = aws_iam_role.mysql.name
  policy_arn = aws_iam_policy.mysql.arn
}


 
resource "aws_iam_instance_profile" "mysql" {
  name = "mysql_ec2_profile"
  role = aws_iam_role.mysql_role.name
}