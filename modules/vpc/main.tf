# VPC
resource "aws_vpc" "new_vpc" {
    cidr_block = "${var.cidr}"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "vpc.${var.env}.${var.client_name}"
        env = "${var.env}"
        Stack = "${var.client_name}"
    }
}

# DHCP
resource "aws_vpc_dhcp_options" "new_vpc-dhcp" {
    domain_name = "${var.domain_name}"
    domain_name_servers = ["8.8.8.8", "8.8.4.4"]
    depends_on = ["aws_vpc.new_vpc"] 
    tags = {
        Name = "dhcp.${var.env}.${var.client_name}"
        env = "${var.env}"
        Stack = "${var.client_name}"
    }
}

# DHCP association
resource "aws_vpc_dhcp_options_association" "new_vpc-dhcp-asso" {
    vpc_id = "${aws_vpc.new_vpc.id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.new_vpc-dhcp.id}"
}

# IGW creation
resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.new_vpc.id}"

    tags = {
        Name = "igw.${var.env}.${var.client_name}"
        env = "${var.env}"
        Stack = "${var.client_name}"
    }
}
