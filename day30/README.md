# Project: 

**Advanced Terraform with Modules, Functions, State Locks, Remote State Management, and Variable Configuration**

## Project Objective:

+ This project will test your skills in using Terraform modules, functions, variables, state locks, and remote state management. 

+ The project requires deploying infrastructure on AWS using a custom Terraform module and managing the state remotely in an S3 bucket, while testing the locking mechanism with DynamoDB. 

+ Participants will also configure variables and outputs using functions.

### Project Overview:


+ You will create a Terraform configuration that uses a custom module to deploy a multi-component infrastructure on AWS. The state files will be stored remotely in an S3 bucket, and DynamoDB will handle state locking. Additionally, the project will involve creating a flexible and reusable Terraform module, using input variables (tfvars) and Terraform functions to parameterize configurations.

**Specifications:**

+ Terraform Modules: Create a reusable module that can deploy both an EC2 instance and an S3 bucket.

+ Terraform Functions: Use Terraform built-in functions to manipulate and compute variable values (e.g., length, join, lookup).

+ State Management: Store the Terraform state in an S3 bucket and configure DynamoDB for state locking to prevent concurrent changes.

+ Variable Configuration (tfvars): Parameterize the infrastructure using variables for instance type, region, and other configurable options.

+ Outputs: Use outputs to display important information such as EC2 instance details and the S3 bucket name after deployment.

### Key Tasks:

### 1. Remote State Management:

+ **S3 Bucket for State:**

    + Create an S3 bucket using Terraform (this can be separate from the custom module).

    + Configure Terraform to store the state file in the S3 bucket.

+ State Locking with DynamoDB:

Create a DynamoDB table using Terraform (or manually if required) to store the state lock information.
Configure Terraform to use this DynamoDB table for state locking.

```hcl
resource "aws_s3_bucket" "bucket" {
  bucket = var.s3_bucket_name
  tags = {
    Name = "app-s3-bucket"
  }
}

resource "aws_dynamodb_table" "state_lock" {
  name           = var.name
  billing_mode   = var.billing_mode
  hash_key       = var.hash_key

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "test"
  }
}
```

### 2. Terraform Module Creation:

+ **Custom Module:**

    + Create a Terraform module to deploy the following AWS resources:

        + EC2 instance: Use an AMI for the region and allow SSH access using a security group.

        + S3 bucket: Create an S3 bucket for application data.

```css
day30/
  ├── modules/
  |   ├── main.tf
  |   ├── variables.tf
  |   └── outputs.tf
  ├── main.tf  
  ├── variables.tf
  ├── outputs.tf 
  ├── backend.tf  
```


+ Use Terraform variables (txvars) to parameterize important aspects such as:
    
    + Instance Type: Allow the instance type to be configurable (e.g., t2.micro).
    
    + Region: Parameterize the AWS region so that the module can be reused across regions.
    
    + Bucket Name: Use a variable to set the S3 bucket name.


```hcl
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

```
**Terraform Functions:**

+ Use Terraform functions in your module to manipulate and process the variables. For example:
    
    + Use join to combine strings for resource names.
    
    + Use lookup to set default values if a variable is not provided.
    
    + Use length to count the number of instances or resources.


### 3. Input Variables and Configuration (txvars):
+ Define input variables to make the infrastructure flexible:
    
    + EC2 instance type.
    
    + S3 bucket name.
    
    + AWS region.
    
    + Any other variable relevant to the infrastructure.

+ Use the default argument for variables where appropriate.

```hcl
variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  default = "ami-085f9c64a9b75eed5"
  type        = string
}

variable "ec2_instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  default = "shiv-key-terraform-stagging"
}
```

### 4. Output Configuration:

+ Set up Terraform outputs to display key information after the infrastructure is created:
    
    + EC2 Public IP: Output the public IP of the EC2 instance.

    ![alt text](image-2.png)
 
    + S3 Bucket Name: Output the name of the S3 bucket created.

    ![alt text](image.png)
    
    + Region: Output the region where the resources were deployed.

### 5. Testing State Locking and Remote State:

+ State Locking:
    
    + Attempt to run terraform apply from two different terminals simultaneously to test state locking.
    
    + Confirm that DynamoDB properly handles the state lock, preventing concurrent updates.

![alt text](image-3.png)

+ Remote State Management:

    + Verify that Terraform state is being stored in the S3 bucket and that updates are reflected in the remote state file.

![alt text](image-4.png)




### 6. Apply and Modify Infrastructure:

+ Initial Deployment:
    
    + Use terraform plan and terraform apply to deploy the infrastructure.
    
    + Verify that the EC2 instance, S3 bucket, and all configurations are properly set up.

+ Infrastructure Changes:
    
    + Modify one of the variables (e.g., change the instance type or add tags) and re-run terraform apply.
    
    + Observe how Terraform plans and applies only the necessary changes, with state locking in effect.

![alt text](image-1.png)