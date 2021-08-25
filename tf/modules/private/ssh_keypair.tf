# keypair to use by ec2-user
resource "aws_key_pair" "priv" {
  key_name = join("_",[var.namespace, "ssh_keypair"])
  public_key = file(var.ec2["ssh_pub_key"])
}

