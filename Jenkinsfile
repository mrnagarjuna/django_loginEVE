pipeline {
    agent any

    environment {
        SSH_CREDENTIAL = 'ec2-ssh-key'        // Jenkins SSH key credential
        SERVER_IP = '13.232.69.21'           // Your EC2 IP
        APP_PATH = '/home/ubuntu/django_loginEVE'  // Path on EC2
        IMAGE_NAME = 'django_loginEVE_app'
        CONTAINER_NAME = 'django_loginEVE_container'
    }

    stages {
        stage('Deploy via Docker on EC2') {
            steps {
                sshagent([SSH_CREDENTIAL]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@${SERVER_IP} << EOF
                        # Navigate to your app folder
                        cd ${APP_PATH}

                        # Pull latest code from GitHub
                        git pull origin main

                        # Remove old container if exists
                        docker rm -f ${CONTAINER_NAME} || true

                        # Build Docker image
                        docker build -t ${IMAGE_NAME} .

                        # Run container in detached mode
                        docker run -d --name ${CONTAINER_NAME} -p 8000:8000 ${IMAGE_NAME}
                    EOF
                    """
                }
            }
        }
    }

    post {
        success {
            echo "Docker container deployed successfully on EC2! 🚀"
        }
        failure {
            echo "Deployment failed. Check Jenkins console logs."
        }
    }
}