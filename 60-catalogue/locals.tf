locals {
    catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
   private_subnet_id = split("," , data.aws_ssm_parameter.private_subnet_ids.value)[0]
    common_tags = {
        project = "roboshop"
        environment = "dev"
        terraform = "true"
    }
}