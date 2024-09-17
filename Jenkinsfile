pipeline {
    agent any

    environment {
        AWS_REGION = ' us-east-1' 
        ECR_REPO = 'test-pipeline'
        REPO_URL = '992382618779.dkr.ecr.us-east-1.amazonaws.com/test-pipeline'
        COMMIT_SHA = ''
        IMAGE_TAG = ''
    }

    triggers {
        githubPush()
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the main branch
                git branch: 'main', url: 'your-repository-url'
            }
        }

        stage('Set Commit SHA') {
            steps {
                script {
                    // Get the first 7 characters of the latest commit SHA
                    COMMIT_SHA = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
                    IMAGE_TAG = "${COMMIT_SHA}"
                    echo "Image will be tagged with: ${IMAGE_TAG}"
                }
            }
        }

        stage('Login to ECR') {
            steps {
                script {
                    // Login to AWS ECR
                    sh '''
                    aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${REPO_URL}
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the latest commit SHA as the tag
                    sh '''
                    docker build -t ${ECR_REPO}:${IMAGE_TAG} .
                    '''
                }
            }
        }

        stage('Push to ECR') {
            steps {
                script {
                    // Tag and push the Docker image to ECR
                    sh '''
                    docker tag ${ECR_REPO}:${IMAGE_TAG} ${REPO_URL}:${IMAGE_TAG}
                    docker push ${REPO_URL}:${IMAGE_TAG}
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Docker image tagged with latest commit SHA and pushed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}


