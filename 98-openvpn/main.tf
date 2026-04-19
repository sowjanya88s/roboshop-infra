resource "aws_instance" "mongodb" {
  ami           = data.aws_ami.openvpn.id
  instance_type = "t3.small"
  vpc_security_group_ids = [local.openvpn_sg_id]
  subnet_id  = local.public_subnet_id
  user_data = file("openvpn.sh")
  tags = merge(local.common_tags ,
  {
    Name = "${var.project}-${var.environment}-openvpn"
  }
  )
}


