resource "aws_instance" "catalogue" {
  ami           = data.aws_ami.example.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.catalogue_sg_id]
  subnet_id  = local.private_subnet_id
  
  tags = merge(local.common_tags ,
  {
    Name = "${var.project}-${var.environment}-catalogue"
  },
  var.catalogue_tags
  )
}

resource "terraform_data" "catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]

  
    connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     =  aws_instance.catalogue.private_ip
  }

  provisioner "file" {
  source = "bootstrap.sh"
  destination = "/tmp/bootstrap.sh"
}


  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh catalogue"
    ]
  }
}

resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"
  depends_on = [terraform_data.catalogue]
}

resource "aws_ami_from_instance" "catalogue" {
  name               = "${var.project}-${var.environment}-catalogue"
  source_instance_id = aws_instance.catalogue.id
  depends_on = [aws_ec2_instance_state.catalogue]
  tags = merge(
  {
    Name = "${var.project}-${var.environment}-catalogue-ami"
  },
  local.common_tags
  )
}

resource "aws_lb_target_group" "catalogue" {
  name        = "${var.project}-${var.environment}-catalogue"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = local.vpc_id
  deregistration_delay = 60

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    interval  = 10
    matcher = "200-299"
    path  = "/health"
    timeout  = 2
    port        = 8080
    protocol    = "HTTP"
  }
}

resource "aws_launch_template" "example" {
  name = "${var.project}-${var.environment}-catalogue"
  image_id = aws_ami_from_instance.catalogue.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t3.micro"
  update_default_version = true
  vpc_security_group_ids = [local.catalogue_sg_id]
   # tags for instances created by launch template through
  tag_specifications {
    resource_type = "instance"
    tags = merge(
        {
      Name = "${var.project}-${var.environment}-catalogue"
    },
    local.common_tags
    )
  }
     # tags for volumes created by launch template through
     tag_specifications {
    resource_type = "volume"
    tags = merge(
        {
      Name = "${var.project}-${var.environment}-catalogue"
    },
   local.common_tags
    )
  }
  
   # tags for  launch template 
  tags = merge(
  {
    Name = "${var.project}-${var.environment}-catalogue-ami"
  },
  local.common_tags
  )

}

