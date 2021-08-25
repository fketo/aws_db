# subnet(s)
resource "aws_subnet" "priv" {
  vpc_id = var.vpc_id
  count = length(var.subnet_cidrs) 

  availability_zone = element(var.av_zones,count.index)

  cidr_block = element(var.subnet_cidrs,count.index)

  map_public_ip_on_launch = "true"
  tags = {
    #Name = join("_",[var.namespace, "subnet", count.index, element(var.av_zones,count.index) ])
    Name = join("_",[var.namespace, "subnet", element(var.av_zones,count.index) ])
  }
}
