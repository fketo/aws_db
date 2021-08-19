# ec2
resource "aws_instance" "base" {
  ami           = var.ec2["instance_ami"]
  instance_type = var.ec2["instance_type"]

  count = length(var.subnet_cidrs) * var.ec2["instance_count"]
  subnet_id = element(aws_subnet.base[*].id,count.index)

  vpc_security_group_ids = [aws_security_group.base.id]
  key_name = aws_key_pair.base.key_name

  tags = {
    Name = join("_",[var.namespace, "ec2", count.index, element(var.av_zones,count.index) ])
  }
}
