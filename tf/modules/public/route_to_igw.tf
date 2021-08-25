# create routing table
resource "aws_route_table" "pub" {
  vpc_id = aws_vpc.pub.id
  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.pub.0.id
    }
  tags = {
    Name = join("_",[var.namespace, "rt_pub"])
    }
}

# associate table to subnet(s)
resource "aws_route_table_association" "pub" {
  count = length(var.subnet_cidrs)
  subnet_id      = element(aws_subnet.pub.*.id, count.index)
  route_table_id = aws_route_table.pub.id
}

