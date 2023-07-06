output "vpc-id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.subnet : subnet.id if subnet.tags.Type == "public"]
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.subnet : subnet.id if subnet.tags.Type == "private"]
}