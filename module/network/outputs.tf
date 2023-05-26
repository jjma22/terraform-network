output "vpc_id" {
  description = "ID of the provisioned VPC"
  value       = aws_vpc.main.id
}

output "availability_zones" {
    description = "Availability zones in VPC"
    value = var.availability-zones
} 

output "public_subnet_ids" {
    description = "IDs of public subnets"
    value = "${aws_subnet.public-subnet.*.id}"
} 
