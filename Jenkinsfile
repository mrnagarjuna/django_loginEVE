pipeline {
    agent any

    environment {
        SSH_CREDENTIAL = 'ec2-ssh-key'        // Jenkins SSH credential ID
        SERVER_IP = '13.232.69.21'           // EC2 IP
        APP_PATH = '/home/ubuntu/django_loginEVE'  // Path to project on server
        IMAGE_NAME = 'django_loginEVE_app'        // Docker image name
        CONTAINER_NAME = 'django_loginEVE_container' // Container name
    }

    stages {

        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/mrnagarjuna/django_loginEVE.git'
            }
        }

        stage('Deploy via Docker') {
            steps {
                sshagent([SSH_CREDENTIAL]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@${SERVER_IP} << EOF
                        cd ${APP_PATH}

                        # Pull latest code
                        git pull origin main

                        # Remove existing container if running
                        docker rm -f ${CONTAINER_NAME} || true

                        # Build new Docker image
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
            echo "Docker deployment completed successfully! 🚀"
        }
        failure {
            echo "Deployment failed. Check Jenkins console logs."
        }
    }
}