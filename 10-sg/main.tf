module "sg" {
    count = length[var.sg_names]
    source = "../../terraform-sg-module"
    sg_names = var.sg_names[count.index]
    vpc_id = local.vpc_id
    project = var.project
    environment = var.environment
}

