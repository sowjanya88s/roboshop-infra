resource "aws_instance" "bastion" {
  ami           = data.aws_ami.example.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.vpc_id]
  subnet_id  = local.public_subnet_ids
  iam_instance_profile = aws_iam_instance_profile.bastion.name


  tags = merge(local.common_tags ,
  {
    Name = "${var.project}-${var.environment}-bastion"
  },
  var.bastion_tags
  )
}

  resource "aws_iam_role" "bastion_role" {
  name = "test_role"

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
    tag-key = "${var.project}-${var.environment}-bastion"
  }
}
resource "aws_iam_role_policy_attachment" "ec2-policy" {
  role       = aws_iam_role.bastion_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}
 
resource "aws_iam_instance_profile" "bastion" {
  name = "bastion_ec2_profile"
  role = aws_iam_role.bastion_role.name
}

