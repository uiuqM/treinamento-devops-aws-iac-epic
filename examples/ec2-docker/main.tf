resource "aws_security_group" "ec2" {
  name   = "ec2-lab"
  vpc_id = aws_vpc.lab.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "lab" {
  key_name   = "chave-lab-iac"
  public_key = file("~/.ssh/lab-iac.pub")
}

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.al2023.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.publica.id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  key_name               = aws_key_pair.lab.key_name

  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf config-manager addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo
    dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    systemctl enable --now docker
    docker run -p 80:5000 shirafelix/flask-app:v1.0
  EOF

  tags = {
    Name = "ec2-lab-iac"
  }
}