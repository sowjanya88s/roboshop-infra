locals {
    mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
   database_subnet_id = split("," , data.aws_ssm_parameter.database_subnet_ids.value)[0]
    common_tags = {
        project = "roboshop"
        environment = "dev"
        terraform = "true"
    }
    redis_sg_id = data.aws_ssm_parameter.redis_sg_id.value
}