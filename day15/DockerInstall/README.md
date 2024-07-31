# Ansible Playbook for Docker Container Deployment

## Project Overview

This project focuses on creating an Ansible playbook to automate the deployment of a Docker container. The playbook will handle the installation of Docker, pulling the Docker image from a container registry, and running the Docker container with the necessary configurations. An inventory file will be used to specify the target servers for deployment.

## Deliverables

### 1. Basic Playbook Creation

- **Objective:** Develop an Ansible playbook to automate the deployment of the Docker container.
- **Outcome:** A fully functional Ansible playbook that performs the specified deployment tasks.

### 2. Playbook Tasks

- **Install Docker:**
  - Ensure Docker is installed on the target server. If Docker is not installed, the playbook will handle the installation process.
  
- **Pull Docker Image:**
  - Pull the Docker image from the specified container registry.

- **Run Docker Container:**
  - Run the Docker container with the required configurations.

### 3. Inventory File

- **Objective:** Create an inventory file specifying the target server(s) for deployment.
- **Outcome:** An inventory file that lists the target servers where the Docker container will be deployed.

## Ansible Playbook Structure

### Playbook File (`deploy_docker.yml`)

```yaml
---
- name: Install Docker and Run an image
  hosts: all
  tasks: 
    - name: install python and Docker
      apt:
        name:
          - python3
          - python3-pip
          - docker.io
        state: present

    - name: Enable docker servcie
      systemd:
        name: docker
        enabled: yes

    - name: Start the docker servcie
      systemd:
        name: docker
        state: started

    - name: Pulling docker image
      docker_image:
        name: shivmodi1203/mynginx
        tag: latest
        source: pull

    - name: Running docker container
      docker_container:
        name: my_test_container
        image: shivmodi1203/mynginx
        state: started
        restart_policy: always
        ports:
          - "80:80"
```

### Inventory File (`inventory.ini`)

```ini
[target_servers]
server1 ansible_host=192.168.1.10 ansible_user=user
```

## Usage Instructions

1. **Ensure Ansible is Installed:**
   - Make sure Ansible is installed on the control machine. You can install Ansible using the following command:
     ```bash
     sudo apt-get install ansible
     ```

2. **Create the Playbook:**
   - Save the above playbook content to a file named `deploy_docker.yml`.

3. **Create the Inventory File:**
   - Save the above inventory content to a file named `inventory.ini`.

4. **Run the Playbook:**
   - Execute the Ansible playbook using the following command:
     ```bash
     ansible-playbook -i inventory.ini deploy_docker.yml
     ```

## Notes

- Ensure that the target servers are accessible from the control machine and that you have the necessary SSH access.
- Customize the Docker image name, container name, and port configurations as per your requirements.

## Conclusion

This README provides a comprehensive guide to creating and using an Ansible playbook for automating the deployment of a Docker container. By following the steps outlined, you can ensure a smooth and efficient deployment process across multiple target servers.