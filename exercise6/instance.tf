resource "aws_key_pair" "terra-key" {
  key_name   = "terrakey"
  public_key = file(var.PUB_KEY)
}

resource "aws_instance" "terra-inst3" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.terra-pub-1.id
  key_name               = aws_key_pair.terra-key.key_name
  vpc_security_group_ids = [aws_security_group.terra-sg.id]
  tags = {
    Name    = "Terra-Inst3"
    Project = "Terra-multi"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  connection {
    user        = var.USER
    private_key = file(var.PRIV_KEY)
    host        = self.public_ip
  }
}

# EBS Volume

resource "aws_ebs_volume" "terra_vol_2" {
  availability_zone = var.ZONE1
  size              = 2

  tags = {
    Name = "Terra-Vol-2"
  }
}

# EBS Volume Attachment

resource "aws_volume_attachment" "ebs_attach_terra_vol_2" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.terra_vol_2.id
  instance_id = aws_instance.terra-inst3.id
}

# Output

output "PublicIP" {
  value = aws_instance.terra-inst3.public_ip
}

