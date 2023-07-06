variable "vpc_name" {
  type = string
}

variable "vpc_cidr_block" {
  description = "vpc cidr block string ex. 10.0.0.0/16"
  type = string
}

variable "subnets_data" {
  description = "subnet cidr data list of objects consists of CIDR range, Availability zone and Public or Private"
  type = map
}

variable "allow_all_ipv4_cidr_blocks" {
  type = string
  default = "0.0.0.0/0"
}

variable "allow_all_ipv6_cidr_blocks" {
  type = string
  default = "::/0"
}

variable "public-subnet-key-to-nat" {
  
}

