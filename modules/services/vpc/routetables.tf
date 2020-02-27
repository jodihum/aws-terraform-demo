/* 
  Route tables for public subnets to access internet gateway
*/

resource "aws_route_table" "public_subnet_one" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = local.all_ips 
        gateway_id = aws_internet_gateway.gateway.id
    }

    tags {
      Name = "Route Table Public Subnet One"
    }
}

resource "aws_route_table_association" "public_subnet_one" {
    subnet_id = aws_subnet.public_subnet_one.id
    route_table_id = aws_route_table.public_subnet_one.id
}

resource "aws_route_table" "public_subnet_two" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = local.all_ips
        gateway_id = aws_nat_gateway.nat_gateway.id
    }

    tags {
      Name = "Route Table Public Subnet Two"
    }
}

resource "aws_route_table_association" "public_subnet_two" {
    subnet_id = aws_subnet.public_subnet_two.id
    route_table_id = aws_route_table.public_subnet_two.id
}

/* 
  Route tables for private subnets to access NAT Gateway
*/

resource "aws_route_table" "private_subnet_one" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = local.all_ips
        gateway_id = aws_nat_gateway.nat_gateway_one.id
    }
    
    tags {
      Name = "Route Table Private Subnet One"
    }
}

resource "aws_route_table_association" "private_subnet_one" {
    subnet_id = aws_subnet.private_subnet_one.id
    route_table_id = aws_route_table.private_subnet_one.id
}

resource "aws_route_table" "private_subnet_two" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = local.all_ips
        gateway_id = aws_nat_gateway.nat_gateway_two.id
    }

    tags {
      Name = "Route Table Private Subnet Two"
    }
}

resource "aws_route_table_association" "private_subnet_two" {
    subnet_id = aws_subnet.private_subnet_two.id
    route_table_id = aws_route_table.private_subnet_two.id
}
