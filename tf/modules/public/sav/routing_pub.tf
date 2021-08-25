# create routing table
resource "aws_route_table" "base_pub" {
  vpc_id = aws_vpc.base.id
  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.base_pub.id
    }
  tags = {
    Name = join("_",[var.namespace, "base_pub_rtb"])
    }
}

# associate table to subnet(s)
resource "aws_route_table_association" "base_pub" {
  count = length(var.subnet_cidrs)
  subnet_id      = element(aws_subnet.base_pub.*.id, count.index)
  route_table_id = aws_route_table.base_pub.id
}

