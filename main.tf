resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name = var.vpc_name
    }
}

resource "aws_subnet" "subnet" {
    vpc_id = aws_vpc.vpc.id
    for_each = var.subnets_data
    cidr_block = each.value.cidr
    availability_zone = each.value.availability_zone
    tags = {
        Name = each.key
        Type = each.value.accessability,
    }
}

resource "aws_internet_gateway" "gateway" {
    vpc_id = aws_vpc.vpc.id
}

resource "aws_eip" "eip" {
  count = var.public-subnet-key-to-nat != "" ? 1 : 0
}

resource "aws_nat_gateway" "nat-gtw" {
  count = var.public-subnet-key-to-nat != "" ? 1 : 0
  subnet_id     = aws_subnet.subnet[var.public-subnet-key-to-nat].id
  allocation_id = aws_eip.eip[0].id
}

resource "aws_route_table" "route-table-public" {
    vpc_id = aws_vpc.vpc.id
    
  route {
    cidr_block = var.allow_all_ipv4_cidr_blocks
    gateway_id = aws_internet_gateway.gateway.id
  }

  route {
    ipv6_cidr_block        = var.allow_all_ipv6_cidr_blocks
    gateway_id = aws_internet_gateway.gateway.id
  }

}

resource "aws_route_table" "route-table-private" {
    vpc_id = aws_vpc.vpc.id
    
  route {
    cidr_block = var.allow_all_ipv4_cidr_blocks
    gateway_id = aws_nat_gateway.nat-gtw[0].id
  }
}

resource "aws_route_table_association" "rt-associate-public" {
  for_each = {
    for key, subnet in var.subnets_data :
    key => subnet
    if subnet.accessability == "public"
  }  
  subnet_id      = aws_subnet.subnet[each.key].id
  route_table_id = aws_route_table.route-table-public.id
}

resource "aws_route_table_association" "rt-associate-private" {
  for_each = {
    for key, subnet in var.subnets_data :
    key => subnet
    if subnet.accessability == "private"
  }
  subnet_id      = aws_subnet.subnet[each.key].id
  route_table_id = aws_route_table.route-table-private.id
}