pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Check out code from GitHub
                git 'https://github.com/yourusername/your-repo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t my-test-image .'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container
                    sh 'docker run --rm my-test-image'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
