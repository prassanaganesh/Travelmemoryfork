# Security Group for Web Server
resource "aws_security_group" "web" {
  name        = "travelmemory-web-sg"
  description = "Security group for TravelMemory web server"
  vpc_id      = aws_vpc.main.id

  # SSH - temporarily allow from anywhere
  # We can restrict this to your IP later
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Application port - adjust if your MERN app uses another port
  ingress {
    description = "Application"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TravelMemory-Web-SG"
  }
}


# Security Group for Database Server
resource "aws_security_group" "database" {
  name        = "travelmemory-database-sg"
  description = "Security group for TravelMemory database server"
  vpc_id      = aws_vpc.main.id

  # MongoDB - allow only from Web Security Group
  ingress {
    description     = "MongoDB from Web Server"
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  # SSH - temporarily allow from anywhere
  # We can restrict this later
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TravelMemory-Database-SG"
  }
}
