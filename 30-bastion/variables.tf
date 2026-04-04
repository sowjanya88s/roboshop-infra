variable "project" {
 type = string
}
variable "environment" {
    type = string
}
variable "bastion_tags" {
    type = map
    default = {}
}