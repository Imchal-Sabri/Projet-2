resource "aws_vpc" "<##INFRA_NAME##>-vpc" {
        cidr_block = "10.<##CLIENT_ID##>.0.0/16"

        tags = {
                Name = "<##INFRA_NAME##>-vpc"
        }
}
