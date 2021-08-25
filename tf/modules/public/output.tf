output "vpc_id" {
  description = "The ID of the VPC"
  value       = concat(aws_vpc.pub.*.id, [""])[0]
}

resource "local_file" "inventory" {
  content = templatefile(var.ansible["ansible_inv_template"],
    {
      group_name   = var.namespace
      public_ips   = aws_instance.pub[*].public_ip
      public_fqdns = aws_instance.pub[*].public_dns
    }
  )
  filename = join("_",[var.ansible["ansible_inv"], var.namespace])
}
