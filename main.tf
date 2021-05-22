provider "aws" {
    access_key = "AKIA2O3EDZYGIY6EMTGA"
    secret_key = "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"
    region = "us-east-1"
}

data "aws_ami" "my_ami" {
     most_recent      = true
     #name_regex       = "^jaya"
     owners           = ["719080115724"]
}


resource "aws_instance" "web-1" {
    ami = "${data.aws_ami.my_ami.id}"
    #ami = "ami-0d857ff0f5fc4e03b"
    availability_zone = "us-east-1a"
    instance_type = "t2.micro"
    key_name = "demo"
    subnet_id = "subnet-0f2a2e06821332e81"
	private_ip = "10.10.1.202"
    vpc_security_group_ids = ["sg-0637fd4886e98ede4"]
    associate_public_ip_address = true	
    tags = {
        Name = "Server-1"
        Env = "Prod"
        Owner = "jaya"
    }
}
