module "vpc" {
  source             = "github.com/terraform-community-modules/tf_aws_vpc?ref=e3637e4db5b28e8396a94f6319b32ad99bb03d8e"
  name               = "${var.application_name}"
  cidr               = "10.0.0.0/16"
  private_subnets    = ["10.0.1.0/24"]
  public_subnets     = ["10.0.100.0/24"]
  azs                = ["us-west-2a", "us-west-2b", "us-west-2c"]
  enable_nat_gateway = "true"
  enable_dns_support = "true"
}

resource "aws_security_group" "ssh" {
  vpc_id = "${module.vpc.vpc_id}"
  name   = "ssh"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "internet" {
  vpc_id = "${module.vpc.vpc_id}"
  name   = "internet"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "application" {
  vpc_id = "${module.vpc.vpc_id}"
  name   = "${var.application_name}"

  ingress {
    protocol    = "tcp"
    from_port   = "${var.application_port}"
    to_port     = "${var.application_port}"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
