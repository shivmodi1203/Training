# EC2 Instance
resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = var.ec2_instance_type
  subnet_id     = var.subnet_id
  key_name = "shiv-key"
  associate_public_ip_address = true
  tags = {
    Name = "shiv-instance"
  }
}