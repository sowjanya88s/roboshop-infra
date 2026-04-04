variable "project" {
 type = string
 default = "roboshop"
}
variable "environment" {
    type = string
    default = "dev"
}
variable "bastion_tags" {
    type = map
    default = {}
}