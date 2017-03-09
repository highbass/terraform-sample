#################
##  Create VPC ##
#################
resource "aws_vpc" "mod" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"
  instance_tenancy = "default"

  tags {
    Name = "${var.environment}_vpc"
    Environment = "${var.environment}"
  }
}

#Create SUBNETS
resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.private_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"
  count             = "${length(var.private_subnets)}"

  tags {
    Name = "${var.environment}-subnet-private-${element(var.azs, count.index)}"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${var.public_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"
  count             = "${length(var.public_subnets)}"

  tags {
    Name = "${var.environment}-subnet-public-${element(var.azs, count.index)}"
    Environment = "${var.environment}"
  }

  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
}

## Create IGW ##
resource "aws_internet_gateway" "mod" {
  vpc_id = "${aws_vpc.mod.id}"

  tags {
    Name = "${var.environment}-igw"
    Environment = "${var.environment}"
  }
}

## Create NAT GW ##

resource "aws_eip" "nateip" {
  vpc   = true
  depends_on = ["aws_internet_gateway.mod"]
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = "${aws_eip.nateip.id}"
  subnet_id     = "${aws_subnet.public.0.id}"
  depends_on = ["aws_eip.nateip"]
}

## Create Route Tables ##

resource "aws_default_route_table" "public" {
  default_route_table_id = "${aws_vpc.mod.default_route_table_id}"
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.mod.id}"
  }
  tags {
    Name = "${var.environment}-rt-public"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnets)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_default_route_table.public.id}"
}

resource "aws_route_table" "private" {
  vpc_id           = "${aws_vpc.mod.id}"
  propagating_vgws = ["${var.private_propagating_vgws}"]
  route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = "${aws_nat_gateway.natgw.id}"
  }
  tags {
    Name = "${var.environment}-rt-private"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table_association" "private" {
  count          = "${length(var.private_subnets)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private.id}"
}
