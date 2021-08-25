resource "local_file" "inventory" {
  content = templatefile(var.ansible["ansible_inv_template"],
    {
      group_name   = var.namespace
      privlic_ips   = aws_instance.priv[*].privlic_ip
      privlic_fqdns = aws_instance.priv[*].privlic_dns
    }
  )
  filename = join("_",[var.ansible["ansible_inv"], var.namespace])
}
