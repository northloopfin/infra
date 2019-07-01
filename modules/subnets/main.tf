# Subnets
resource "aws_subnet" "public" {
  count             = "${length(compact(split(",", var.public_subnets_cidr)))}"
  availability_zone = "${var.aws_region}${element(split(",", var.availablity_zones), count.index)}"
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${element(split(",", var.public_subnets_cidr), count.index)}"

  tags = {
    Name  = "sub.pub.${element(split(",", var.availablity_zones), count.index)}.${terraform.workspace}.${count.index}"
    env   = "${terraform.workspace}"
    Stack = "${var.client_name}"
  }
}

resource "aws_subnet" "private" {
  count             = "${length(compact(split(",", var.private_subnets_cidr)))}"
  availability_zone = "${var.aws_region}${element(split(",", var.availablity_zones), count.index)}"
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${element(split(",", var.private_subnets_cidr), count.index)}"

  tags = {
    Name  = "sub.priv.${element(split(",", var.availablity_zones), count.index)}.${terraform.workspace}.${count.index}"
    env   = "${terraform.workspace}"
    Stack = "${var.client_name}"
  }
}

# Public subnets route tables
resource "aws_route_table" "rtpub" {
  count  = "${length(compact(split(",", var.public_subnets_cidr)))}"
  vpc_id = "${var.vpc_id}"
  
  lifecycle  {
    ignore_changes = ["propagating_vgws"]
  }
  
  tags = {
    Name  = "rtpub.${terraform.workspace}.${var.client_name}.${count.index}"
    env   = "${terraform.workspace}"
    Stack = "${var.client_name}"
  }
}

resource "aws_route" "public_default" {
  count                  = "${length(compact(split(",", var.public_subnets_cidr)))}"
  route_table_id         = "${element(aws_route_table.rtpub.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${var.gw_id}"
}

resource "aws_route" "vpc_peering_route" {
  count                       = "${length(compact(split(",", var.public_subnets_cidr))) * length(compact(split(",", var.vpc_peering_id)))}"
  route_table_id              = "${element(aws_route_table.rtpub.*.id, count.index)}"
  destination_cidr_block      = "${var.vpc_peering_destination_cidr_block}"
  vpc_peering_connection_id   = "${var.vpc_peering_id}"
}


# Private subnet route table
resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.eip_nat.id}"
  subnet_id     = "${element(aws_subnet.public.*.id, 0)}"
}

resource "aws_eip" "eip_nat" {
  vpc   = true
}

resource "aws_route" "private_default" {
  count                  = "${length(compact(split(",", var.private_subnets_cidr)))}"
  route_table_id         = "${element(aws_route_table.rtpriv.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.gw.id}"
}

resource "aws_route_table" "rtpriv" {
  count  = "${length(compact(split(",", var.private_subnets_cidr)))}"
  vpc_id = "${var.vpc_id}"

  lifecycle {
    ignore_changes = ["propagating_vgws"]
  }

  tags = {
    Name  = "rtpriv.${terraform.workspace}.${var.client_name}.${count.index}"
    env   = "${terraform.workspace}"
    Stack = "${var.client_name}"
  }
}

# Public subnet associations
resource "aws_route_table_association" "public" {
  count          = "${length(compact(split(",", var.public_subnets_cidr)))}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.rtpub.*.id, count.index)}"
}

# Private subnet associations
resource "aws_route_table_association" "private" {
  count          = "${length(compact(split(",", var.private_subnets_cidr)))}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.rtpriv.*.id, count.index)}"
}
