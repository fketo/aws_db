#internet gw
resource "aws_internet_gateway" "base" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = join("_",[var.namespace, "igw"])
  }
}

