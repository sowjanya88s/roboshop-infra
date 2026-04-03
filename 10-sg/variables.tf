variable "sg_names" {
    type = list
    default = ["mongodb", "mysql" ,"redis" ,"rabbitmq", "catalogue", "user", 
                "cart", "shipping", "payment" ,"frontend","frontend_alb" ,"backend_alb"]
}

variable "project" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}