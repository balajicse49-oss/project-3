pipeline {
    agent any

    environment {
        IMAGE_NAME = "balajimari/project-3:latest"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                url: 'https://github.com/balajicse49-oss/project-3.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                chmod +x build.sh
                ./build.sh project-3 latest
                '''
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    '''
                }
            }
        }

        stage('Tag Image') {
            steps {
                sh '''
                docker tag project-3:latest $IMAGE_NAME
                '''
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                sh '''
                docker push $IMAGE_NAME
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                chmod +x deploy.sh
                ./deploy.sh $IMAGE_NAME latest
                '''
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
