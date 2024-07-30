# Jenkins-Docker

## Project 01

### Problem Statement:
You are tasked with setting up a CI/CD pipeline using Jenkins to streamline the deployment process of a simple Java application. The pipeline should accomplish the following tasks:

- Fetch the Dockerfile: The pipeline should clone a GitHub repository containing the source code of the Java application and a Dockerfile.
![alt text](image.png)
- Create a Docker Image: The pipeline should build a Docker image from the fetched Dockerfile.
### Dockerfile
```
FROM openjdk:11
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN javac App.java
CMD ["java", "App"]
```
![alt text](image-1.png)
![alt text](image-2.png)
### Jenkinsfile
```
pipeline{

    agent any

    environment{
        dockerImage = ''
        registry = 'shivmodi1203/jenkins_docker_image'
        registryCredentials = 'Docker'
    }

    stages{
        stage('Build Docker Image'){
            steps{
                script{
                    dockerImage = docker.build("${registry}:latest")
                }
            }
        }
        stage('Push Docker Image'){
            steps{
                script{
                    docker.withRegistry('https://hub.docker.com/', registryCredentials){
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Deploy Container'){
            steps{
                script{
                    docker.withRegistry('https://hub.docker.com/', registryCredentials){
                        def runContainer = docker.image("${registry}:${env.BUILD_ID}").run('--name mynew-container -d')
                        echo "Container ID: ${runContainer.id}"
                    }
                }
            }
        }
    }
}
```
- Push the Docker Image: The pipeline should push the created Docker image to a specified DockerHub repository.
![alt text](image-3.png)
- Deploy the Container: The pipeline should deploy a container using the pushed Docker image.
