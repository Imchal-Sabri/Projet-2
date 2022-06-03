resource "aws_vpc" "<##INFRA_NAME##>-vpc" {
        cidr_block = "10.<##CLIENT_ID##>.0.0/16"

        tags = {
                Name = "<##INFRA_NAME##>-vpc"
        }
}

resource "aws_subnet" "<##INFRA_NAME##>-subadm" {
        vpc_id = "${aws_vpc.<##INFRA_NAME##>-vpc.id}"
        cidr_block = "10.<##CLIENT_ID##>.1.0/24"

        tags = {
                Name = "<##INFRA_NAME##>-subadm"
        }
}

resource "aws_internet_gateway" "<##INFRA_NAME##>-igw" {
        vpc_id = "${aws_vpc.<##INFRA_NAME##>-vpc.id}"

        tags = {
                Name = "<##INFRA_NAME##>-igw"
        }
}

resource "aws_route" "<##INFRA_NAME##>-defroute" {
        route_table_id = "${aws_vpc.<##INFRA_NAME##>-vpc.default_route_table_id}"
        destination_cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.<##INFRA_NAME##>-igw.id}"
}

resource "aws_route_table" "<##INFRA_NAME##>-privrtb" {
        vpc_id = aws_vpc.<##INFRA_NAME##>-vpc.id
        route {
                cidr_block     = "0.0.0.0/0"
                nat_gateway_id = aws_nat_gateway.<##INFRA_NAME##>-natgw.id
        }
}

resource "aws_route_table_association" "<##INFRA_NAME##>-privrtb-assoc1" {
        route_table_id = aws_route_table.<##INFRA_NAME##>-privrtb.id
        subnet_id      = aws_subnet.<##INFRA_NAME##>-priv.id
}
