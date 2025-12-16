resource "aws_instance" "web_server" {

  ami           = "ami-0a7cf821b91bcccbc"   # Amazon Linux 2 (Mumbai)
  instance_type = "t3.medium"

  associate_public_ip_address = true

  user_data = <<-EOF
  #!/bin/bash
  exec > /var/log/user-data.log 2>&1
  set -eux

  echo "=== USER DATA START ==="

  apt-get update -y

  apt-get install -y docker.io

  systemctl daemon-reload
  systemctl start docker
  systemctl enable docker

  docker --version

  docker pull muhammadsafad/django-backend:v1

  docker run -d -p 8000:8000 --restart=always \
    muhammadsafad/django-backend:v1

  echo "=== USER DATA END ==="
  EOF



  tags = {
    Name = "GitHubActions-WebApp"
    Environment = "dev"
  }
}
