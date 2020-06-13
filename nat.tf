#NAT EIP
resource "aws_eip" "nat" {
	vpc = true
}
#NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
	allocation_id = aws_eip.nat.id
	subnet_id = aws_subnet.Public_subnet1.id
	depends_on = [ aws_internet_gateway.InternetgatewaybyT]
}
#VPC for NAT
resource "aws_route_table" "main_private" {
	vpc_id = aws_vpc.main.id
	route {
		cidr_block = "0.0.0.0/0"
		nat_gateway_id = aws_nat_gateway.nat_gw.id
	}
	tags = {
		name = "private_route1"
	}
}
# route assocaition
resource "aws_route_table_association" "private_route1a" {
	subnet_id = aws_subnet.private_subnet1.id
	route_table_id = aws_route_table.main_private.id
}
resource "aws_route_table_association" "private_route1b" {
        subnet_id = aws_subnet.private_subnet2.id
        route_table_id = aws_route_table.main_private.id
}
resource "aws_route_table_association" "private_route1c" {
        subnet_id = aws_subnet.private_subnet3.id
        route_table_id = aws_route_table.main_private.id
}


		
	

