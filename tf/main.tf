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
  av_zones = ["eu-central-1a"]

  # clear ebs list -> no ebs will attached
  ebs = []

  # set namespace as element in naming schema
  namespace = "public_env"
}

module "private" {
  source = "./modules/private"

  # subnet cidr / av_zone (these both have to be in conjunction)
  subnet_cidrs = ["128.0.2.0/24", "128.0.3.0/24","128.0.4.0/24"]
  av_zones = ["eu-central-1a", "eu-central-1b","eu-central-1c",]

  # if false is set no instances are created 
  with_ec2 = false

  # clear ebs list -> no ebs will attached
  ebs = []

  namespace = "private_env"
}
