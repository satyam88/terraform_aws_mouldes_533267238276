module "my_vpc" {
  source          = "git::https://github.com/satyam88/terraform_aws_mouldes.git//modules/vpc?ref=v1.5"
  vpc_name        = "my-vpc"
  cidr_block      = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
}

module "mysql_db" {
  source                 = "git::https://github.com/satyam88/terraform_aws_mouldes.git//modules/mysqldb?ref=v1.5"
  db_name                = var.db_name
  db_username            = var.db_username
  db_password            = var.db_password
  instance_class         = var.instance_class
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_ids = [
    module.my_vpc.private_subnets_ids[0],
    module.my_vpc.private_subnets_ids[1]
  ]
}




module "ec2" {
  source        = "git::https://github.com/satyam88/terraform_aws_mouldes.git//modules/ec2?ref=v1.8"
  instance_type = "t3.micro"
}