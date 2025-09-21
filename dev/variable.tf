
variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(string)
}