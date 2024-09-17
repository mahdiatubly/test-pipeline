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
                git branch: 'main', url: 'https://github.com/mahdiatubly/test-pipeline.git'
            }
        }

        stage('Set Commit SHA') {
            steps {
                script {
                    COMMIT_SHA = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
                    IMAGE_TAG = "${COMMIT_SHA}"
                    echo "Image will be tagged with: ${IMAGE_TAG}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh '''
                    docker build -t ${ECR_REPO}:${IMAGE_TAG} .
                    '''
                }
            }
        }

        stage('Push to ECR') {
            steps {
                script {
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


