module "create-network" {
    source = "./module/network"
    vpc-name = "ce-project-vpc"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

module "launch-instances" {
    vpc_id = module.create-network.vpc_id
    source = "./module/launch-instance"
    security_groups_ipv4_init_params = [{
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "http 80"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      description = "custom 3000"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH"
      cidr_blocks = "${chomp(data.http.myip.body)}/32"
    }
    ]
    user-data = file("${path.module}/user-data.sh")
    public-subnet-ids = module.create-network.public_subnet_ids
}


