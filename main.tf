resource "aws_instance" "web_server" {

  ami           = "ami-0a7cf821b91bcccbc"   # Amazon Linux 2 (Mumbai)
  instance_type = "t3.medium"

  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              yum update -y

              # Install Docker
              amazon-linux-extras install docker -y
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ec2-user

              # Install Git
              yum install git -y

              # Pull your Docker image (CHANGE THIS)
              docker pull muhammadsafad/django-backend:v1

              # Run container
              docker run -d -p 8000:8000 \
                --restart=always \
                muhammadsafad/django-backend:v1
              EOF

  tags = {
    Name = "GitHubActions-WebApp"
    Environment = "dev"
  }
}
