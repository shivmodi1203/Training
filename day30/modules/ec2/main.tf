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
    EOT
  }
}

# EC2 Instance
resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = var.ec2_instance_type
  key_name = var.key_name
  associate_public_ip_address = true
  tags = {  
    Name = "shiv-instance-${terraform.workspace}"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(aws_key_pair.key_pair.key_name)
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }

  provisioner "local-exec" {
    command = <<EOT
    echo "${self.public_ip} ansible_user=ec2-user ansible_ssh_private_key_file=${var.key_name}" >> ./inventory
    EOT
  }

}