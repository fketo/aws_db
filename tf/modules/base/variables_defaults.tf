# aws profile/aws regions aa
variable "profile" {
  type = string
  description = "profile aws-cli"
  default = "NONE"
}
variable "region" {
  type = string
  description = "region aws-cli"
  default = "NONE"
}

# naming
variable "namespace" {
  type = string
  description = "namespace for building unique name tags"
  default = "NONE"
}

# is_public {
variable "is_public" {
  type = bool
  default = true
}

# vpc
variable "vpc_cidr" {
  description = "vpc_cidr"
  default = "128.0.0.0/16"
}

# subnets (keep in mind the aws elb can't deal with multiple subnets in a av-zone)
# default = ["128.0.1.0/24", "128.0.2.0/24", "128.0.3.0/24"] 
variable "subnet_cidrs" {
  description = "pub_subnet_cidrs"
  type = list
  default = ["128.0.1.0/24"] 
}

# avz
# default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
variable "av_zones" {
  description = "used av zones"
	type = list
	default = ["eu-central-1a"]
}

# ec2 ebs enable 0/1
# default = 0
variable ebs_count {
  default= 0
}

# ec2
variable "ec2" {
  description = "ec2 attributes"
  type = map
  default = {
    "instance_ami"  = "ami-0a02ee601d742e89f"
    "instance_type"  = "t2.nano"
    "instance_count" = 1
    "ssh_pub_key" = "./files/keys/ec2-user.pub"
    "ssh_priv_key" = "./files/keys/ec2-user"
  }
}

# ebs
# list for more ebs 
variable "ebs" {
  description = "ebs storage, multiple device via list"
  default = [{
    ebs_vol_size    = 1
    ebs_device      = "/dev/sdb"
    ebs_vol_size    = 1
    ebs_vol_type    = "gp2"
  }]
}

# ansible
variable "ansible" {
  description = "ansible attributes"
  type        = map(any)
  default = {
    "ansible_inv_template" = "./files/templates/ansible_inventory.template"
    "ansible_inv"          = "../ansible/inventories/inventory"
  }
}

