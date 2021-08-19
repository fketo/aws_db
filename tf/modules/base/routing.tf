# create routing table
resource "aws_route_table" "base" {
  vpc_id = aws_vpc.base.id
  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.base.id
    }
  tags = {
    Name = join("_",[var.namespace, "rtb"])
    }
}

# associate table to subnet(s)
resource "aws_route_table_association" "base" {
  count = length(var.subnet_cidrs)
  subnet_id      = element(aws_subnet.base.*.id, count.index)
  route_table_id = aws_route_table.base.id
}

