/*
  lookup an ubuntu lts ami id
*/
data "aws_ami" "ubuntu_lts" {
  most_recent = true

  # 099720109477 is Canonical's account ID
  owners = ["099720109477"]

  # exclude /images-testing, for stable daily snapshots only
  filter {
    name   = "manifest-location"
    values = ["*/ubuntu/images/*"]
  }

  filter {
    name   = "name"
    values = ["*xenial*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  # paravirtual lets us use a last-gen m1.Large, which is a good fit
  filter {
    name   = "virtualization-type"
    values = ["paravirtual"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "is-public"
    values = ["true"]
  }

}
