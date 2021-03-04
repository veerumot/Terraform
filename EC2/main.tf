provider "aws" {
	region = "us-east-1"
}

  resource "aws_key_pair" "terraform-keys2" {
  key_name   = "terraform-keys2"
   public_key = "${file("./terraform-keys2.pub")}"
 }


# locals {
#   subnet_id = "subnet-3aa2f970"
# }

data "template_file" "user_data" {
  template = "${file("./userdata.sh")}"
}

resource "aws_security_group" "my_demo_sg" {
  name        = "my_demo"
  description = "Allow inbound traffic"
  vpc_id      = "vpc-2da40357"

  ingress {
    description = "Inbound from port_80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH connection"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS connection"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "my-demo-instance" {
	ami = "ami-0e9089763828757e1"
	instance_type = "t2.micro"
  depends_on = [
    aws_key_pair.terraform-keys2,
  ]
	key_name = "${aws_key_pair.terraform-keys2.key_name}"
  # public_key = file("./terraform-keys2.pub")
  # key_pair_id = "aws_key_pair.key-00959af8d54011e8d"
	user_data = "data.template_file.user_data.rendered"
  vpc_security_group_ids = ["${aws_security_group.my_demo_sg.id}"]
  subnet_id                   = "subnet-3aa2f970"
  associate_public_ip_address = "true"
	tags = {
		Name = "My-Terraform-Instance"	
	}
}
