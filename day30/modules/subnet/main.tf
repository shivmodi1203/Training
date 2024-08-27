# Public Subnet
resource "aws_subnet" "public" {
  count = length(var.cidr_block)
  vpc_id            = var.vpc_id
  cidr_block        = "${var.cidr_block[count.index]}"
  map_public_ip_on_launch = true
  availability_zone = "${var.availability_zone[count.index]}"
  tags = {
    Name = "public-subnet-${terraform.workspace}"
  }
}