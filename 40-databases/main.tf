resource "aws_instance" "mongodb" {
  ami           = data.aws_ami.example.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.mongodb_sg_id]
  subnet_id  = local.database_subnet_id
  
  tags = merge(local.common_tags ,
  {
    Name = "${var.project}-${var.environment}-mongodb"
  },
  var.bastion_tags
  )
}

resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongodb.id
  ]

  provisioner "remote-exec" {
    connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     =  self.public_ip
  }

  provisioner "file" {
  source = "bootstrap.sh"
  destination = "/tmp/bootstrap.sh"
}


  provisioner "remote-exec" {
    inline = [
      "chmod +x bootstrap.sh",
      "sudo sh bootstrap.sh mongodb"
    ]
  }
    
  }
}


resource "aws_instance" "redis" {
  ami           = data.aws_ami.example.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.redis_sg_id]
  subnet_id  = local.database_subnet_id
  
  tags = merge(local.common_tags ,
  {
    Name = "${var.project}-${var.environment}-redis"
  },
  var.bastion_tags
  )
}

resource "terraform_data" "redis" {
  triggers_replace = [
    aws_instance.redis.id
  ]

  provisioner "remote-exec" {
    connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     =  self.public_ip
  }

  provisioner "file" {
  source = "bootstrap.sh"
  destination = "/tmp/bootstrap.sh"
}


  provisioner "remote-exec" {
    inline = [
      "chmod +x bootstrap.sh",
      "sudo sh bootstrap.sh redis"
    ]
  }
    
  }
}
