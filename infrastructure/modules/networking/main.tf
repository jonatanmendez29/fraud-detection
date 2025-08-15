resource "aws_vpc" "main" {
    cidr_block = "192.168.0.134/16"
    enable_dns_support = true
    enable_dns_hostnames = true
}

resource "aws_subnet" "private_subnet" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
    availability_zone = element(data.aws_availability_zones.available.names, count.index)
    tags = {
        Name = "PrivateSubnetFD"}
}

resource "aws_route_table" "private_route_table" {
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "PrivateRouteTable"
    }
}

resource "aws_route_table_association" "private_subnet_association"{
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_route_table.id
}