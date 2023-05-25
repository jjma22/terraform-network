resource "aws_vpc" "main" {
  cidr_block       = var.vpc-cidr-range
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public-subnet" {
    count = length(var.public-subnet-ips)
    vpc_id = aws_vpc.main.id
    cidr_block = var.public-subnet-ips[count.index]
    availability_zone = var.availability-zones[count.index]
    map_public_ip_on_launch = true
    tags = {
        Name = "public-subnet-${count.index + 1}"
    }
}

resource "aws_subnet" "private-subnet" {
    count = length(var.private-subnet-ips)
    vpc_id = aws_vpc.main.id
    cidr_block = var.private-subnet-ips[count.index]
    availability_zone = var.availability-zones[count.index]
    tags = {
        Name = "private-subnet-${count.index + 1}"
    }
}

#Create internet gateway

resource "aws_internet_gateway" "terraform-gw" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "terraform-project-internet-gateway"
    }
}

#connect public subnets to public route table

resource "aws_route_table_association" "public" {
  count = length(var.public-subnet-ips)
  subnet_id      = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_vpc.main.default_route_table_id
}

#create EIP
resource "aws_eip" "EIP" {
  count = length(var.private-subnet-ips)
  vpc = true
}

#create nat gateways
resource "aws_nat_gateway" "nat_gw" {
    count = length(var.private-subnet-ips)
    allocation_id = aws_eip.EIP[count.index].id
    subnet_id = aws_subnet.private-subnet[count.index].id

}

#create prive route tables 
resource "aws_route_table" "private_route" {
    count = length(var.private-subnet-ips)
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gw[count.index].id
    }
    tags = {
        Name = "private_route_table-${count.index + 1}"
    }
}

#connet private subnets to nat gateways

resource "aws_route_table_association" "private-route-connection" {
  count = length(var.private-subnet-ips)
  subnet_id      = aws_subnet.private-subnet[count.index].id
  route_table_id = aws_route_table.private_route[count.index].id
}
