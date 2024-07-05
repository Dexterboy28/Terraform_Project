#
resource "aws_vpc" "myvpc"{
    cidr_block ="10.0.0.0/16"
    tags = {
           Name = "MyTerraformvpc"
    }
}

resource "aws_subnet" "PublicSubnet"{
      vpc_id = aws_vpc.myvpc.id
      cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "PrivateSubnet"{
      vpc_id = aws_vpc.myvpc.id
      cidr_block = "10.0.2.0/24"
}

resource "aws_internet_gateway" "igw"{
       vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "publicRT"{
      vpc_id = aws_vpc.myvpc.id
      route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
      }
}

resource "aws_route_table_association" "publicRTassociation" {
      subnet_id = aws_subnet.PublicSubnet.id
      route_table_id = aws_route_table.publicRT.id

}

