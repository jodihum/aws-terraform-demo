local {
  http_port = 80
  https_port = 443
  any_port = 0
  ssh_port = 22
  tcp_protocol = "tcp"
  all_ips = "0.0.0.0/0"
}

resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr}"
}

resource "aws_internet_gateway" "gateway" {
    vpc_id = aws_vpc.vpc.id
}

resource "aws_network_acl" "public_subnet" {

    vpc_id = "${aws_vpc.vpc.id}"
    subnet_ids = [
        "${aws_subnet.public_subnet.id}"
    ]

    ingress {
        protocol    = "tcp"
        rule_no     = 100
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 80
        to_port     = 80
    }

    ingress {
        protocol    = "tcp"
        rule_no     = 110
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 443
        to_port     = 443
    }

    ingress {
        protocol    = "tcp"
        rule_no     = 120
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 22
        to_port     = 22
    }

    ingress {
        protocol   = "tcp"
        rule_no    = 130
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 1024
        to_port    = 65535
    }

    ingress {
        protocol    = -1
        rule_no     = 140
        action      = "deny"
        cidr_block  = "0.0.0.0/0"
        from_port   = 0
        to_port     = 0
    }

    egress {
        protocol    = "tcp"
        rule_no     = 100
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 80
        to_port     = 80
    }

    egress {
        protocol   = "tcp"
        rule_no    = 110
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 443
        to_port    = 443
    }

    egress {
        protocol    = "tcp"
        rule_no     = 120
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 1024
        to_port     = 65535
    }

    egress {
        protocol   = "tcp"
        rule_no    = 400
        action     = "allow"
        cidr_block = "${var.private_subnet_cidr}"
        from_port  = 22
        to_port    = 22
    }

    egress {
        protocol   = -1
        rule_no    = 1000
        action     = "deny"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }

    tags {
        Name = "network-acl-${var.public_subnet_name}"
        Description = "ACL rules for public subnet"
    }
}

resource "aws_network_acl" "private_subnet" {

    vpc_id = "${aws_vpc.vpc.id}"
    subnet_ids = [
        "${aws_subnet.private_subnet.id}"
    ]

    ingress {
        protocol    = "tcp"
        rule_no     = 100
        action      = "allow"
        cidr_block  = "${var.public_subnet_cidr}"
        from_port   = 22
        to_port     = 22
    }

    ingress {
        protocol    = "tcp"
        rule_no     = 110
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 1024
        to_port     = 65535
    }

    ingress {
        protocol    = -1
        rule_no     = 120
        action      = "deny"
        cidr_block  = "0.0.0.0/0"
        from_port   = 0
        to_port     = 0
    }

    egress {
        protocol    = "tcp"
        rule_no     = 100
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 80
        to_port     = 80
    }

    egress {
        protocol    = "tcp"
        rule_no     = 110
        action      = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 443
        to_port     = 443
    }

    egress {
        protocol    = "tcp"
        rule_no     = 120
        action      = "allow"
        cidr_block  = "${var.public_subnet_cidr}"
        from_port   = 32768
        to_port     = 65535
    }

    egress {
        protocol    = -1
        rule_no     = 130
        action      = "deny"
        cidr_block  = "0.0.0.0/0"
        from_port   = 0
        to_port     = 0
    }
    
    tags {
        Name = "network-acl-${var.private_subnet_name}"
        Description = "ACL rules for private subnet"
    }
}























***************************************

resource "aws_internet_gateway" "default" {
    vpc_id = aws_vpc.vpc.id
}

/*
  NAT Instance
  TODO - do I need this?  Should it go somewhere else?
*/
resource "aws_security_group" "nat" {
    name = "vpc_nat"
    description = "Allow traffic to pass from the private subnet to the internet"

    vpc_id = aws_vpc.vpc.id

    tags {
        Name = "NATSG"
    }
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type = "ingress"
  security_group_id = aws_security_group.nat.id

  from_port = http_port
  to_port = http_port
  protocol = tcp_protocol
  cidr_blocks = ["${var.private_subnet_one_cidr}","${var.private_subnet_two_cidr}"]
}

resource "aws_security_group_rule" "allow_https_inbound" {
  type = "ingress"
  security_group_id = aws_security_group.nat.id
  
  from_port = https_port
  to_port = https_port
  protocol = tcp_protocol
  cidr_blocks = ["${var.private_subnet_one_cidr}","${var.private_subnet_two_cidr}"]
}
    
resource "aws_security_group_rule" "allow_ssh_inbound" {
  type = "ingress"
  security_group_id = aws_security_group.nat.id
 
  from_port = ssh_port
  to_port = ssh_port
  protocol = tcp_protocol
  cidr_blocks = ["${var.private_subnet_one_cidr}","${var.private_subnet_two_cidr}"]
}



ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }


 egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    egress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

# create 2 public and 2 private subnets 
resource "aws_subnet" "private-a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.0/28"
  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone       = var.availabilityZone
tags = {
   Name = "My VPC Subnet"
}
