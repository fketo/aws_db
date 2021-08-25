output "subnet_ids" {
  description = "list of subnet ids"
  value       = aws_subnet.priv[*].id
}

resource "local_file" "inventory" {
  content = templatefile(var.ansible["ansible_inv_template"],
    {
      group_name   = var.namespace
      public_ips   = aws_instance.priv[*].public_ip
      public_fqdns = aws_instance.priv[*].public_dns
    }
  )
  filename = join("_",[var.ansible["ansible_inv"], var.namespace])
}
