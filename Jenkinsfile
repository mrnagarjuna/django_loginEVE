pipeline {
    agent any

    environment {
        SSH_CREDENTIAL = 'ec2-ssh-key'          // Jenkins SSH credential ID
        SERVER_IP     = '13.232.69.21'          // EC2 IP
        APP_PATH      = '/home/ubuntu/django_loginEVE'
        IMAGE_NAME    = 'django_logineve_app'
        CONTAINER_NAME = 'django_logineve_container'
        GITHUB_TOKEN  = credentials('github-token')   // GitHub PAT secret
    }

    stages {
        stage('Deploy to EC2') {
            steps {
                sshagent([SSH_CREDENTIAL]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@${SERVER_IP} << EOF
                        mkdir -p ${APP_PATH}
                        cd ${APP_PATH}

                        # Pull latest code from GitHub
                        if [ -d ".git" ]; then
                            git reset --hard
                            git pull https://\$GITHUB_TOKEN@github.com/mrnagarjuna/django_loginEVE.git main
                        else
                            git clone https://\$GITHUB_TOKEN@github.com/mrnagarjuna/django_loginEVE.git ${APP_PATH}
                        fi

                        # Remove old container
                        docker rm -f ${CONTAINER_NAME} || true

                        # Build Docker image
                        docker build -t ${IMAGE_NAME} .

                        # Run Docker container
                        docker run -d --name ${CONTAINER_NAME} -p 8000:8000 ${IMAGE_NAME}

                        # List running containers
                        docker ps
                    EOF
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ Deployment successful! Visit http://${SERVER_IP}:8000"
        }
        failure {
            echo "❌ Deployment failed. Check Jenkins logs."
        }
    }
}