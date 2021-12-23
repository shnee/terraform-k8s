resource "aws_instance" "nodes" {
  ami                         = var.ami
  instance_type               = var.ec2-instance-type
  # TODO Make this a variable.
  associate_public_ip_address = true
  subnet_id = element(var.subnet-ids, count.index % length(var.subnet-ids))
  vpc_security_group_ids = var.security-group-ids
  user_data = element(var.user-datas.*.rendered, count.index)
  count                       = var.num-nodes

  tags = {
    Name = "${var.name-prefix}-${count.index}"
  }
}
