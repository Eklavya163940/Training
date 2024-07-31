pipeline{

    agent any

    environment{
        dockerImage = ''
        registry = 'eklavya163940/jenkins-docker'
        registryCredentials = 'dockerhub-credentials'
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
                    docker.withRegistry('', registryCredentials){
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
 