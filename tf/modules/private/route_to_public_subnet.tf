# create routing table
resource "aws_route_table" "priv" {
  vpc_id = var.vpc_id
  tags = {
    Name = join("_",[var.namespace, "rt_priv"])
    }
}

# associate table to subnet(s)
resource "aws_route_table_association" "priv" {
  count = length(var.subnet_cidrs)
  subnet_id      = element(aws_subnet.priv.*.id, count.index)
  route_table_id = aws_route_table.priv.id
}

