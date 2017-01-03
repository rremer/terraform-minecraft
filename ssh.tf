resource "aws_key_pair" "terraform" {
  key_name   = "${var.application_name}"
  public_key = "${var.ssh_public_key}"
}
