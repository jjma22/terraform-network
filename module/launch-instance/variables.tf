
variable "ec2_name" {
  description = "Name of instance"
  type        = string
  default     = "my_instance"
}

variable "availability-zones" {
  description = "Availability zones"
  type = list(string)
  default = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]  
}
  


variable "ec2-assossciated-public-ip" {
  description = "Associate public IP address with EC2 instance"
  type        = bool
  default     = true
}

variable "ec2-ami" {
  description = "Choice of ami for ec2 instance"
  type        = string
  default     = "ami-0eb260c4d5475b901"
}

variable "ec2-instance-type" {
  description = "Instance type for ec2"
  type        = string
  default     = "t2.micro"
}



# aws security group variables


variable "security_groups_ipv4_init_params" {
  description = "Parameters for security groups"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = string
    cidr_blocks = string
  }))
  default = [
    {
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
  
  ]
}

variable "security_groups_ipv6_init_params" {
  description = "Parameters for security groups"
  type = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    description      = string
    ipv6_cidr_blocks = string
  }))
  default = [
    {
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      description      = "http 80"
      ipv6_cidr_blocks = "::/0"
    },
    {
      from_port        = 3000
      to_port          = 3000
      protocol         = "tcp"
      description      = "custom 3000"
      ipv6_cidr_blocks = "::/0"
    }
  ]
}

variable "key-name" {
  description = "Key name"
  type = string 
  default = "NewKeyPairNameFirstAttempt"
}


variable "vpc_id" {
  description = "VPC ID"
  type = string
  default ="please provide"
}

# variable "user-data" {
#   type = string
#   default = "hello world"
# }