resource "aws_security_group" "cicd-sg" {
  name        = "cicd-sg"
  description = "Allow end user with http"
  vpc_id      = "vpc-049f215e85a9ff2c2"

  ingress {
    description      = "connecting end user on Http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "connecting Admin on SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "cicd-sg"
    terrsform ="true"
  }
}
  resource "aws_instance" "cicd" {
  ami           = "ami-0b89f7b3f054b957e"
  instance_type = "t2.micro"

  subnet_id = "subnet-072762878afe76c41"
  vpc_security_group_ids=[aws_security_group.cicd-sg.id]

  iam_instance_profile = aws_iam_instance_profile.artifactory.name
  #key_name="test"

  key_name = aws_key_pair.demo.id

    user_data              = <<-EOF
wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum upgrade -y
amazon-linux-extras install java-openjdk11
yum install jenkins -y
systemctl start jenkins
systemctl enable jenkins
              EOF

  tags = {
    Name = "cicd"
  }
}
