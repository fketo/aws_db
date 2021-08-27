resource "aws_db_subnet_group" "default" {
  name       = "mydbsubentgroup"
  subnet_ids = aws_subnet.priv[*].id

}