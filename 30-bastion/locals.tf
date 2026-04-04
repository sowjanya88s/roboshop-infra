locals {
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    public_subnet_ids = "${join("," , data.aws_ssm_parameter.public_subnet_ids.value)[0]}"
    common_tags = {
        project = "roboshop"
        environment = "dev"
        terraform = "true"
    }
}