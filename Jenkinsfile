pipeline {
    agent any
    
    environment {
        DOCKER_HUB_CREDS = credentials('dockerhub-credentials')
        DOCKER_IMAGE_NAME = 'maleeha/mlopsassignment1'
        DOCKER_IMAGE_TAG = "${env.BUILD_NUMBER}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    bat "docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} ."
                }
            }
        }
        
        stage('Login to DockerHub') {
            steps {
                script {
                    bat "docker login -u ${DOCKER_HUB_CREDS_USR} -p ${DOCKER_HUB_CREDS_PSW}"
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    bat "docker push ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                    bat "docker tag ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} ${DOCKER_IMAGE_NAME}:latest"
                    bat "docker push ${DOCKER_IMAGE_NAME}:latest"
                }
            }
        }
    }
    
    post {
        success {
            emailext (
                subject: "SUCCESSFUL: Pipeline '${currentBuild.fullDisplayName}'",
                body: "The pipeline ${currentBuild.fullDisplayName} has been deployed successfully.\n\nDocker image: ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}",
                to: 'maleeha139@gmail.com',  
                from: 'maleeha139@gmail.com'
'
            )
        }
        
        failure {
            emailext (
                subject: "FAILED: Pipeline '${currentBuild.fullDisplayName}'",
                body: "The pipeline ${currentBuild.fullDisplayName} has failed. Please check the logs.",
                to: 'maleeha139@gmail.com', 
                from: 'maleeha139@gmail.com'
'
            )
        }
        
        always {
            // Clean up workspace
            cleanWs()
        }
    }
}