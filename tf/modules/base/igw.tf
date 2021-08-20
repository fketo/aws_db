#internet gw
resource "aws_internet_gateway" "base" {
  count = var.is_public == true ? 1 : 0
  vpc_id = aws_vpc.base.id
  tags = {
    Name = join("_",[var.namespace, "igw"])
  }
}

