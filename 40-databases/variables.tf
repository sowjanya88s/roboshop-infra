variable "project" {
    type = string
    default = "roboshop"
}
variable  "environment" {
    type = string
    default = "dev"
}
variable "zone_id" {
    type = string
    default = "Z082049010RMR2FN1A4VI"
}
variable "domain_name" {
    type = string
    default = "sowjanya.fun"
}
variable "mongodb_tags" {
    type = map
    default = {}
}
variable "redis_tags" {
    type = map
    default = {}
}