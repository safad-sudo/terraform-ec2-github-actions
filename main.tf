resource "aws_instance" "web_server" {

  ami           = "ami-0a7cf821b91bcccbc"   # Amazon Linux 2 (Mumbai)
  instance_type = "t3.medium"

  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    set -eux

    apt-get update -y
 
  # Install Docker
    apt-get install -y docker.io

    systemctl start docker
    systemctl enable docker

  # Allow ubuntu user to run docker
    usermod -aG docker ubuntu

  # Pull and run the web app
    docker pull YOUR_DOCKERHUB_USERNAME/django-backend:v1
    docker run -d -p 8000:8000 --restart=always \
      YOUR_DOCKERHUB_USERNAME/django-backend:v1
  EOF


  tags = {
    Name = "GitHubActions-WebApp"
    Environment = "dev"
  }
}
