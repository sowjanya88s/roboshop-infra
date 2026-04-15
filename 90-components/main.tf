module "roboshop" {
    for_each = var.components
    source = "git::https://github.com/sowjanya88s/terraform-roboshop-component.git?ref=main"
    component = each.key
    priority = each.value.priority
}