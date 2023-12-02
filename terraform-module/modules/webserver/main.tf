terraform {
  required_version = ">=0.12"
}

resource "aws_subnet" "webserver" {
    vpc_id = var.vpc_id # aws_vpc.main.id 
    cidr_block = var.cidr_block # aws_vpc.main.cidr_block
}

resource "aws_instance" "webserver" {
    ami = var.ami # ami-0230bd60aa48260c6 us-east-1 amazon linux 2023
    instance_type = var.instance_type # "t2.micro"
    subnet_id = aws_subnet.webserver.id

    tags = {
        Name = "${var.webserver_name} webserver"
    }
}