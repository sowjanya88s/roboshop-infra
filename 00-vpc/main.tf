module "vpc" {
    source = "git::https://github.com/sowjanya88s/terraform-vpc-module.git?ref=main"
    project = var.project
    environment = var.environment
    is_peering_required = true
    }