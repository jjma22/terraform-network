#VPC Variables
variable "vpc-cidr-range" {
    description = "CIDR range of VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "vpc-name" {
    type = string
    default = "main"
}

variable "public-subnet-ips" {
    description = "CIDR range for public subnets"
    type = list(string)
    default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24",]
}

variable "private-subnet-ips" {
    description = "CIDR range for public subnets"
    type = list(string)
    default = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24",]
}

variable "availability-zones" {
    description = "Availability zones"
    type = list(string)
    default = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}



