# security group ec2
resource "aws_security_group" "pub" {
  name = join("_",[var.namespace, "sg_ec2"])
  vpc_id = aws_vpc.pub.id
  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = join("_",[var.namespace, "sg_ec2"])
  }
}

