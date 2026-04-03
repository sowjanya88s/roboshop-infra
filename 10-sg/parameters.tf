resource "aws_ssm_parameter" "sg_ids" {
  count = length(var.sg_names)
  name  = "/${var.project}/${var.environment}/var.sg_names[count.index]"
  type  = "String"
  value = module.sg.sg_ids
  }