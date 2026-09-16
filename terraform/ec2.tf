# ============================================================
# Ubuntu 24.04 AMI - Web Server
# ============================================================

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = [
    "099720109477"
  ]

  filter {
    name = "name"

    values = [
      "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
    ]
  }

  filter {
    name = "virtualization-type"

    values = [
      "hvm"
    ]
  }
}


# ============================================================
# Ubuntu 22.04 AMI - Database Server
# ============================================================

data "aws_ami" "ubuntu_2204" {
  most_recent = true

  owners = [
    "099720109477"
  ]

  filter {
    name = "name"

    values = [
      "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    ]
  }

  filter {
    name = "virtualization-type"

    values = [
      "hvm"
    ]
  }
}


# ============================================================
# SSH Key Pair
# ============================================================

resource "aws_key_pair" "travelmemory" {
  key_name = "${var.project_name}-key"

  public_key = file(
    pathexpand(var.public_key_path)
  )
}


# ============================================================
# Web Server
# Ubuntu 24.04
# ============================================================

resource "aws_instance" "web" {
  ami = data.aws_ami.ubuntu.id

  instance_type = var.instance_type

  subnet_id = aws_subnet.public.id

  vpc_security_group_ids = [
    aws_security_group.web.id
  ]

  key_name = aws_key_pair.travelmemory.key_name

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  associate_public_ip_address = true

  root_block_device {
    volume_size = 12
    volume_type = "gp3"
    encrypted   = true
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name = "${var.project_name}-web-server"
  }
}


# ============================================================
# Database Server
# Ubuntu 22.04
# ============================================================

resource "aws_instance" "database" {
  ami = data.aws_ami.ubuntu_2204.id

  instance_type = var.instance_type

  subnet_id = aws_subnet.private.id

  vpc_security_group_ids = [
    aws_security_group.database.id
  ]

  key_name = aws_key_pair.travelmemory.key_name

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  associate_public_ip_address = false

  root_block_device {
    volume_size = 12
    volume_type = "gp3"
    encrypted   = true
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name = "${var.project_name}-database-server"
  }
}
