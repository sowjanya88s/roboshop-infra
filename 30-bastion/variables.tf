variable "project" {
 type = String
}
variable "environment" {
    type = String
}
variable "bastion_tags" {
    type = map
    default = {}
}