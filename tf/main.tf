# version/local backend
terraform {
  required_version = ">= 0.12"
  backend "local" {
    path = "state/terraform.tfstate"
  }
}

# aws client
provider "aws" {
 #profile = "devops"
  region  = "eu-central-1"
}


# only need to be set if there is a change from the default
# look at ./modules/base/variables_defaults.tf for default settings in the module
# keep in mind, maps have to declarated with all vars (no matter, if only one variable changes)

# module call
module "public" {
  source = "./modules/public"

  # vpc cidr
  vpc_cidr = "128.0.0.0/16"

  # subnet cidr / av_zone (these both have to be in conjunction)
  subnet_cidrs = ["128.0.1.0/24"]
  av_zones     = ["eu-central-1a"]

  # clear ebs list -> no ebs will attached
  ebs = []

  # set namespace as element in naming schema
  namespace = "public_env"
}

# module call
module "private" {
  source = "./modules/private"

  # vpc id from module public
  vpc_id = module.public.vpc_id

  # subnet cidr / av_zone (these both have to be in conjunction)
  subnet_cidrs = ["128.0.2.0/24", "128.0.3.0/24", "128.0.4.0/24"]
  av_zones     = ["eu-central-1a", "eu-central-1b", "eu-central-1c", ]

  # if false is set no instances are created 
  with_ec2 = false

  # clear ebs list -> no ebs will attached
  ebs = []

  namespace = "private_env"
}

# module call
#module "rds" {
#  source = "./modules/rds"
#
#  # vpc id from module public
#  subnet_ids = module.private.subnet_ids
#
#  namespace = "private_env"
#}



################################################################################
# RDS Module
################################################################################

module "db_instance" {
  source = "./modules/db_instance"

  identifier = "orcl"

  engine               = "oracle-se2"
  engine_version       = "12.1.0.2.v8"
  #family               = "oracle-ee-12.1" # DB parameter group
  #major_engine_version = "12.1"           # DB option group
  instance_class       = "db.t3.small"
  license_model        = "bring-your-own-license"

  storage_type          = "gp2"
  allocated_storage     = 20
  max_allocated_storage = 100
  storage_encrypted     = false

  # Make sure that database name is capitalized, otherwise RDS will try to recreate RDS instance every time
  name                   = "DBNAME"
  username               = "myadmin"
  password               = "Sun12345"
  #create_random_password = true
  #random_password_length = 12
  port                   = 1521

  multi_az               = true
  db_subnet_group_name   = module.private.aws_subnet_group_id


  #vpc_security_group_ids = [module.security_group.security_group_id]

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["alert", "audit"]

  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  create_monitoring_role                = false

  # See here for support character sets https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.OracleCharacterSets.html
  character_set_name = "AL32UTF8"

    #tags = local.tags
}