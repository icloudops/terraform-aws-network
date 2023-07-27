# Terraform Module: AWS VPC with Public and Private Subnets

## Module description:

This Terraform module creates an Amazon Web Services (AWS) Virtual Private Cloud (VPC) with public and private subnets. The module allows you to define the VPC CIDR block, subnet CIDR ranges, availability zones, and their accessibility (public or private). It also creates an internet gateway for public subnets and NAT gateways for private subnets to enable outbound internet access.

## Inputs:

The following are the inputs to the module:

### vpc_name

Type: String.

Description: Name of the VPC that will be created.

### vpc_cidr_block

Type: String

Description: CIDR block for the VPC. Example: "10.0.0.0/16"

### subnets_data

Type: Map

Description: A map of subnet configurations. Each key represents a unique subnet name, and the value is a map with the following attributes:

cidr: CIDR range for the subnet.

availability_zone: The AWS availability zone in which the subnet will be created.

accessability: Accessibility of the subnet, can be either "public" or "private".

### allow_all_ipv4_cidr_blocks (Optional)

Type: String

Default: "0.0.0.0/0"

Description: The CIDR block for allowing all IPv4 traffic. Default value is "0.0.0.0/0".

### allow_all_ipv6_cidr_blocks (Optional)

Type: String

Default: "::/0"

Description: The CIDR block for allowing all IPv6 traffic. Default value is "::/0".

### public-subnet-key-to-nat (Optional)

Type: String

Description: The key of the public subnet for which a NAT gateway will be created. If set, a NAT gateway will be created for this subnet to enable outbound internet access for private subnets.


## Outputs

The following are the outputs provided by the module:

### vpc-id

Description: The ID of the created VPC.

### public_subnet_ids

Description: A list of IDs of the public subnets created in the VPC.

### private_subnet_ids

Description: A list of IDs of the private subnets created in the VPC.

## Example

Expected post request to be casted to the input.auto.tfvars

```
{
    "vpc_name": "my_project",
    "vpc_cidr_block": "10.0.0.0/16",
    "subnets_data": {
        "subnet1": {
        "cidr": "10.0.0.0/24",
        "availability_zone": "us-east-1a",
        "accessability": "public"
        },
        "subnet2": {
        "cidr": "10.0.2.0/24",
        "availability_zone": "us-east-1b",
        "accessability": "public"
        },
        "subnet3": {
        "cidr": "10.0.1.0/24",
        "availability_zone": "us-east-1a",
        "accessability": "private"
        },
        "subnet4": {
        "cidr": "10.0.3.0/24",
        "availability_zone": "us-east-1b",
        "accessability": "private"
        }
    },
    "public-subnet-key-to-nat": "subnet1"
}

```

Expected outputs in the reponse after applying the module

```

{
  "vpc_id": "vpc-1234567890abcdef0",
  "public_subnet_ids": ["subnet-abcdefgh12345678", "subnet-abcdefgh87654321"],
  "private_subnet_ids": ["subnet-ijklmnop12345678", "subnet-ijklmnop87654321"]
}

```