# Public Subnet
resource "aws_subnet" "public" {
  count = length(var.cidr_block)
  vpc_id            = var.vpc_id
  cidr_block        = "${var.cidr_block[count.index]}"
  map_public_ip_on_launch = true
  availability_zone = "${var.availability_zone[count.index]}"
  tags = {
    Name = "public-subnet"
  }
}
# resource "aws_subnet" "public2" {
#   vpc_id            = var.vpc_id
#   cidr_block        = "10.0.2.0/24"
#   map_public_ip_on_launch = true
#   availability_zone = "us-east-2b"
#   tags = {
#     Name = "public-subnet"
#   }
# }