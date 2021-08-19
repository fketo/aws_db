# version/local backend
terraform {
  required_version = ">= 0.12"
  backend "local" {
    path = "state/terraform.tfstate"
  }
}

# aws client
provider "aws" {
  profile = "devops"
  region  = "eu-central-1"
}

# module call
module "public" {
  source = "./modules/base"

  # only need to be set if there is a change from the default
  # look at ./modules/base/variables_defaults.tf for default settings in the module
  # keep in mind, maps have to declarated with all vars (no matter, if only one variable changes)

  # clear ebs list -> no ebs will attached
  ebs = {}

  # set namespace as element in naming schema
  namespace = "public_env"
}

#module "private" {
#  source = "./modules/base"
#
  # only need to be set if there is a change from the default
  # look at ./modules/base/variables_defaults.tf
  # keep in mind, maps have to declarated with all vars (no matter, if only one variable changes)

#  subnet_cidrs =  ["128.0.1.0/24"]

#  av_zones = ["eu-central-1a"]

#  namespace = "public_env"
#}
