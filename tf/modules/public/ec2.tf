# ec2
resource "aws_instance" "pub" {
  ami           = var.ec2["instance_ami"]
  instance_type = var.ec2["instance_type"]

  count = length(var.subnet_cidrs) * var.ec2["instance_count"]
  subnet_id = element(aws_subnet.pub[*].id,count.index)

  vpc_security_group_ids = [aws_security_group.pub.id]
  key_name = aws_key_pair.pub.key_name
  
  dynamic "ebs_block_device" {
   for_each = var.ebs
   content {
     device_name = ebs_block_device.value.ebs_device
     volume_type = ebs_block_device.value.ebs_vol_type
     volume_size = ebs_block_device.value.ebs_vol_size
    }
  }

  tags = {
    Name = join("_",[var.namespace, "ec2_pub", count.index, element(var.av_zones,count.index) ])
  }
}
