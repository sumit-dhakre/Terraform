# VPC
resource "aws_vpc" "main"{
	cidr_block = "10.0.0.0/16"
	instance_tenancy = "default"
	enable_dns_support = true
	enable_dns_hostnames = true
	enable_classiclink = false
	tags = {
		name = "main"
	}
}
#Subnet1
resource "aws_subnet" "Public_subnet1" {
	vpc_id = aws_vpc.main.id
	cidr_block = "10.0.1.0/24"
	availability_zone = "ap-south-1a"
	map_public_ip_on_launch = true
	tags = {
		name = "public_subnet1"
	}
}
#Subnet2
resource "aws_subnet" "public_subnet2" {
	vpc_id = aws_vpc.main.id
	cidr_block = "10.0.2.0/24"
	availability_zone = "ap-south-1b"
	map_public_ip_on_launch = true
	tags = {
		name = "public_subnet2"
	}
}
#subnet3
resource "aws_subnet" "public_subnet3" {
	vpc_id = aws_vpc.main.id
	cidr_block = "10.0.3.0/24"
	availability_zone = "ap-south-1c"
	map_public_ip_on_launch = true
	tags = {
		name = "public_subnet3"
	}
}
#Private_subnet1
resource "aws_subnet" "private_subnet1" {
	vpc_id = aws_vpc.main.id
	cidr_block = "10.0.4.0/24"
	map_public_ip_on_launch = false
	availability_zone = "ap-south-1a"
	tags = {
		name = "private_subnet1"
	}
}
#private subnet2
resource "aws_subnet" "private_subnet2" {
	vpc_id = aws_vpc.main.id
	cidr_block = "10.0.5.0/24"
	map_public_ip_on_launch = false
	availability_zone = "ap-south-1b"
	tags = {
		name = "private_subnet2"
	}
}
#private subnet 3
resource "aws_subnet" "private_subnet3" {
	vpc_id = aws_vpc.main.id
	cidr_block = "10.0.6.0/24"
	map_public_ip_on_launch = false
	availability_zone = "ap-south-1c"
	tags = {
		name = "private_subnet3"
	}
}
#internet gateway
resource "aws_internet_gateway" "InternetgatewaybyT" {
	vpc_id = aws_vpc.main.id
	tags = {
		name = "Internet gateway by terraform"
	}
}
resource "aws_route_table" "route_tableT" {
	vpc_id = aws_vpc.main.id
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.InternetgatewaybyT.id
	}
	tags = {
		name = "routetablebyterraform"
	}
}
#route association public
resource "aws_route_table_association" "public_1a" {
	subnet_id = aws_subnet.Public_subnet1.id
	route_table_id = aws_route_table.route_tableT.id
}
#route association public
resource "aws_route_table_association" "public_1b" {
        subnet_id = aws_subnet.public_subnet2.id
        route_table_id = aws_route_table.route_tableT.id
}
#route association public
resource "aws_route_table_association" "public_1c" {
        subnet_id = aws_subnet.public_subnet3.id
        route_table_id = aws_route_table.route_tableT.id
}

