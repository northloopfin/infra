output "vpc_id" {
    value = "${aws_vpc.new_vpc.id}"
}
output "gw_id" {
	value = "${aws_internet_gateway.gw.id}"
}
