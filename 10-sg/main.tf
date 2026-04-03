module "mongodb-sg" {
    source = "../../terraform-sg-module"
    component = var.component
    vpc_id = local.vpc_id
    project = var.project
    environment = var.environment
}

