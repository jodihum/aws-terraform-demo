resource "aws_eip" "nat_one" {
  vpc = true

  tags = merge(
    local.common_tags,
    map(
      "Name", "EIP for NAT One"
    )
  )
}

resource "aws_nat_gateway" "nat_one" {
  allocation_id = aws_eip.nat_one.id
  subnet_id = aws_subnet.public_subnet_one.id
  
  tags = merge(
    local.common_tags,
    map(
      "Name", "NAT Gateway One" 
    )
  )
}

resource "aws_eip" "nat_two" {
  vpc = true

  tags = merge(
    local.common_tags,
    map(
      "Name", "EIP for NAT Two"
    )
  )
}

resource "aws_nat_gateway" "nat_two" {
  allocation_id = aws_eip.nat_two.id
  subnet_id = aws_subnet.public_subnet_two.id
 
  tags = merge(
    local.common_tags,
    map(
      "Name", "NAT Gateway Two" 
    )
  )
}

resource "aws_instance" "nat_one" {
  ami                         = data.aws_ami.nat.id
  instance_type               = var.nat_instance_type
  source_dest_check           = false
  subnet_id                   = aws_subnet.public_subnet_one.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.access_via_nat.id]

  tags = merge(
    local.common_tags,
    map(
      "Name", "NAT One" 
    )
  )
}

resource "aws_instance" "nat_two" {
  ami                         = data.aws_ami.nat.id
  instance_type               = var.nat_instance_type
  source_dest_check           = false
  subnet_id                   = aws_subnet.public_subnet_two.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.access_via_nat.id]

  tags = merge(
    local.common_tags,
    map(
      "Name", "NAT Two" 
    )
  )
}

# gets ami for use with nat
data "aws_ami" "nat" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-vpc-nat*"]
  }

  owners = ["amazon"]
}

resource "aws_security_group" "access_via_nat" {
  name = "Access to nat instance"
  description = "Access to internet via nat instance for private nodes"
  vpc_id = aws_vpc.vpc.id

  # outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [local.all_ips]
  }
}
