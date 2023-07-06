# set vpc components variables
vpc_name = "my_project"
vpc_cidr_block = "10.0.0.0/16"

subnets_data = {
      "subnet1"={
      "cidr": "10.0.0.0/24",
      "availability_zone": "us-east-1a",
      "accessability": "public"
      },
      "subnet2"={
      "cidr": "10.0.2.0/24",
      "availability_zone": "us-east-1b",
      "accessability": "public"
      },
      "subnet3"={
      "cidr": "10.0.1.0/24",
      "availability_zone": "us-east-1a",
      "accessability": "private"
      },
      "subnet4"={
      "cidr": "10.0.3.0/24",
      "availability_zone": "us-east-1b",
      "accessability": "private"
      },
}


public-subnet-key-to-nat = "subnet1"
