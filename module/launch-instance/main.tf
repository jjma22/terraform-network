

resource "aws_instance" "new_instance" {
  ami                         = var.ec2-ami
  instance_type               = var.ec2-instance-type
  availability_zone           = var.availability-zones[0]
  associate_public_ip_address = var.ec2-assossciated-public-ip
  key_name                    = var.key-name
  security_groups             = [aws_security_group.new_sg.name]
  user_data = var.user-data


  tags = {
    Name = "${var.ec2_name}"
  }
}

resource "aws_security_group" "new_sg" {
  name        = "new_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_vpc_security_group_ingress_rule" "ipv4_rules_ingress" {
  security_group_id = aws_security_group.new_sg.id

  count       = length(var.security_groups_ipv4_init_params[*].from_port)
  from_port   = var.security_groups_ipv4_init_params[count.index].from_port
  to_port     = var.security_groups_ipv4_init_params[count.index].to_port
  ip_protocol = var.security_groups_ipv4_init_params[count.index].protocol
  cidr_ipv4   = var.security_groups_ipv4_init_params[count.index].cidr_blocks


}

resource "aws_vpc_security_group_ingress_rule" "ipv6_rules_ingress" {
  security_group_id = aws_security_group.new_sg.id

  count       = length(var.security_groups_ipv6_init_params[*].from_port)
  from_port   = var.security_groups_ipv6_init_params[count.index].from_port
  to_port     = var.security_groups_ipv6_init_params[count.index].to_port
  ip_protocol = var.security_groups_ipv6_init_params[count.index].protocol
  cidr_ipv6   = var.security_groups_ipv6_init_params[count.index].ipv6_cidr_blocks


}
