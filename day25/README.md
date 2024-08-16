
# Deploying a Path-Based Routing Web Application on AWS

## Objective

This project aims to evaluate your skills in deploying web applications on AWS using EC2 instances, configuring security groups, and setting up an Application Load Balancer (ALB) with path-based routing. By the end of this project, you will have deployed two simple web applications, configured the ALB to route traffic based on the URL path, and terminated all resources after completion.

## Project Scenario

A small company requires the deployment of two lightweight web applications, **"App1"** and **"App2,"** on AWS. The traffic to these applications must be routed through a single ALB, based on the URL path. For cost efficiency, the company has chosen to use t2.micro instances.

## Project Steps and Deliverables

### 1. EC2 Instance Setup
- **Launch EC2 Instances:**
  - Launch four EC2 t2.micro instances using the Amazon Linux 2 AMI.
  - SSH into each instance and deploy a simple web application:
    - Deploy "App1" on two instances.
    - Deploy "App2" on the other two instances.
  - Assign tags to the instances for easy identification (e.g., "App1-Instance1," "App1-Instance2," "App2-Instance1," "App2-Instance2").

### 2. Security Group Configuration
- **Create Security Groups:**
  - Create a security group for the EC2 instances that allows inbound HTTP (port 80) and SSH (port 22) traffic from your IP address.
  - Create a security group for the ALB that allows inbound traffic on port 80.
  - Attach the appropriate security groups to the EC2 instances and ALB.

### 3. Application Load Balancer Setup with Path-Based Routing
- **Create an Application Load Balancer (ALB):**
  - Set up an ALB in the same VPC and subnets as your EC2 instances.
  - Configure the ALB with two target groups:
    - **Target Group 1:** For "App1" instances.
    - **Target Group 2:** For "App2" instances.
  - Register the appropriate EC2 instances with each target group.
- **Configure Path-Based Routing:**
  - Set up path-based routing rules on the ALB:
    - Route traffic to "App1" instances when the URL path is `/app1`.
    - Route traffic to "App2" instances when the URL path is `/app2`.
  - Set up health checks for each target group to ensure the instances are healthy and available.

### 4. Testing and Validation
- **Test Path-Based Routing:**
  - Access the ALB's DNS name and validate that requests to `/app1` are correctly routed to the "App1" instances, and that `/app2` requests are routed to the "App2" instances.
- **Security Validation:**
  - Attempt to access the EC2 instances directly via their public IPs to ensure that only your IP address can SSH into the instances.

### 5. Resource Termination
- **Terminate EC2 Instances:**
  - Stop and terminate all EC2 instances.
- **Delete Load Balancer and Target Groups:**
  - Delete the ALB and the associated target groups.
- **Cleanup Security Groups:**
  - Delete the security groups created for the project.

### 6. Documentation and Reporting
- **Brief Documentation:**
  - Document the steps taken during the project, including the setup of EC2 instances, security groups, and ALB configuration.
- **Final Report:**
  - Summarize the project, highlighting any challenges faced and how they were resolved.