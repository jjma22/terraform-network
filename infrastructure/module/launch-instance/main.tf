

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

#create launch template
resource "aws_ami_from_instance" "nginx" {
  name               = "nginx-example"
  source_instance_id = aws_instance.new_instance.id
}

resource "aws_launch_template" "nginx_launch_template" {
    name = "nginx_launch_template"
   
    image_id = aws_ami_from_instance.nginx.id
    key_name = var.key-name
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.new_sg.id]
    
    user_data = "${base64encode(var.user-data)}"
}

resource "aws_lb_target_group" "nginx" {
  name     = "nginx"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "my-alb"

  load_balancer_type = "application"

  vpc_id             = var.vpc_id
  subnets            = var.public-subnet-ids
  security_groups    = [aws_security_group.new_sg.id]
  }

resource "aws_alb_listener" "alb-listener-group" {
  load_balancer_arn = "${module.alb.lb_arn}"
  port = "80"
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.nginx.id
    type             = "forward"
  }
}

module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  name = "terraform-asg"

  create_launch_template = false
  launch_template = aws_launch_template.nginx_launch_template.name
   vpc_zone_identifier = var.public-subnet-ids
   target_group_arns = ["${aws_lb_target_group.nginx.id}"]

   health_check_type = "EC2"

  min_size = 2
  max_size = 4
  desired_capacity = 3
}