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
module "bastion_env" {
  source = "./modules/base"

  # only need to be set if there is a change from the default
  # look at ./modules/base/variables_defaults.tf

  subnet_cidrs =  ["128.0.1.0/24"]

  av_zones = ["eu-central-1a"]

  namespace = "bastion_etomer"
}
