resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
 
 
// Create Key Pair for Connecting EC2 via SSH
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}
 
// Save PEM file locally
resource "local_file" "private_key" {
  content  = tls_private_key.rsa_4096.private_key_pem
  filename = var.key_name
 
  provisioner "local-exec" {
    command = <<EOT
      chmod 400 ${var.key_name}
      cp ${var.key_name} "${var.key_name}.pem"
    EOT
  }
}

# EC2 Instance
resource "aws_instance" "app" {
  count = length(var.ec2_name)
  ami           = var.ami_id
  instance_type = var.ec2_instance_type[count.index]
  vpc_security_group_ids = var.security_group_ids
  key_name = var.key_name
  associate_public_ip_address = true
  # iam_instance_profile = var.iam_instance_profile
  subnet_id = var.public_subnet_id
  tags = {  
    Name = "shiv-instance-${var.ec2_name[count.index]}"
  }

}