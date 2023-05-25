output "vpc_id" {
  description = "ID of the provisioned VPC"
  value       = aws_vpc.main.id
}

output "availability_zones" {
    description = "Availability zones in VPC"
    value = var.availability-zones
}