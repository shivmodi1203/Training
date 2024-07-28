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
    }
}