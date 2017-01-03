resource "aws_instance" "vpc_ec2" {
  ami                         = "${data.aws_ami.ubuntu_lts.image_id}"
  key_name                    = "${aws_key_pair.terraform.key_name}"
  subnet_id                   = "${module.vpc.public_subnets[0]}"
  instance_type               = "${var.aws_ec2_instance_type}"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = ["${aws_security_group.ssh.id}", "${aws_security_group.internet.id}", "${aws_security_group.application.id}"]

  root_block_device {
    volume_type           = "standard"
    volume_size           = 10
    delete_on_termination = true
  }

  ephemeral_block_device {
    device_name  = "/dev/xvdb"
    virtual_name = "ephemeral0"
  }

  ephemeral_block_device {
    device_name  = "/dev/xvdc"
    virtual_name = "ephemeral1"
  }

  tags {
    Name = "${var.application_name}"
  }

  connection {
    user        = "${var.connection_user}"
    private_key = "${var.ssh_private_key}"
  }

  provisioner "remote-exec" {
    /*
      - some amis boot with an unresolveable hostname, annoying fix
      - update the apt cache and install aptdaemon: paralellel apt
        installations by terraform modules
    */
    inline = [
      "sudo sed -i '/^127.0.0.1/ s/$/ '$(hostname)'/' /etc/hosts",
      "sudo apt-get update -qq",
      "sudo apt-get install -qy aptdaemon",
    ]
  }
}

module "lvm" {
  source                 = "./lvm"
  connection_host        = "${aws_instance.vpc_ec2.public_ip}"
  connection_user        = "${var.connection_user}"
  connection_private_key = "${var.ssh_private_key}"
  devices                = ["/dev/xvdb","/dev/xvdc"]
}

module "ntp" {
  source                 = "./ntp"
  connection_host        = "${aws_instance.vpc_ec2.public_ip}"
  connection_user        = "${var.connection_user}"
  connection_private_key = "${var.ssh_private_key}"
}

module "minecraft" {
  source                            = "./minecraft"
  connection_host                   = "${aws_instance.vpc_ec2.public_ip}"
  connection_user                   = "${var.connection_user}"
  connection_private_key            = "${var.ssh_private_key}"
  minecraft_port                   = "${var.application_port}"
  minecraft_backup_enabled          = "false"
  minecraft_data_symlink            = "${module.lvm.volume_mount_point}"
}

module "backup" {
  source                 = "./backup/s3"
  connection_host        = "${aws_instance.vpc_ec2.public_ip}"
  connection_user        = "${var.connection_user}"
  connection_private_key = "${var.ssh_private_key}"

  backup_endpoint        = "${var.application_name}.${var.domain_name}"
  backup_directory       = "${module.lvm.volume_mount_point}"
}
