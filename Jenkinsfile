pipeline {
    agent any

    environment {
        BACKEND_IMAGE  = "nhikute987654321/backend_app"
        FRONTEND_IMAGE = "nhikute987654321/frontend_app"
        TAG = "${BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'a24dcab6-30ed-44f5-be02-a65181d1f27e',
                    url: 'https://github.com/nhikute987654321/capstone-mern-todo-app002.git'
            }
        }

        stage('Check for Changes') {
            steps {
                script {
                    // Check if backend directory changed
                    env.BACKEND_CHANGED = sh(
                        script: "git diff --name-only HEAD~1 HEAD | grep '^backend/'",
                        returnStatus: true
                    ) == 0 ? "true" : "false"

                    // Check if frontend directory changed
                    env.FRONTEND_CHANGED = sh(
                        script: "git diff --name-only HEAD~1 HEAD | grep '^frontend/'",
                        returnStatus: true
                    ) == 0 ? "true" : "false"

                    echo "Backend changed: ${env.BACKEND_CHANGED}"
                    echo "Frontend changed: ${env.FRONTEND_CHANGED}"
                }
            }
        }

        stage('Build & Push Backend') {
            when { expression { env.BACKEND_CHANGED == 'true' } }
            steps {
                dir('backend') {
                    sh "docker build -t $BACKEND_IMAGE:$TAG ."
                    withCredentials([usernamePassword(
                        credentialsId: 'dockerhub',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )]) {
                        sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    }
                    sh "docker push $BACKEND_IMAGE:$TAG"
                }
            }
        }

        stage('Build & Push Frontend') {
            when { expression { env.FRONTEND_CHANGED == 'true' } }
            steps {
                dir('frontend') {
                    sh "docker build -t $FRONTEND_IMAGE:$TAG ."
                    withCredentials([usernamePassword(
                        credentialsId: 'dockerhub',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )]) {
                        sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    }
                    sh "docker push $FRONTEND_IMAGE:$TAG"
                }
            }
        }

        stage('Deploy Backend') {
            when { expression { env.BACKEND_CHANGED == 'true' } }
            steps {
                sh '''
                docker stop backend_app || true
                docker rm backend_app || true
                docker run -d -p 8000:8000 --name backend_app $BACKEND_IMAGE:$TAG
                '''
            }
        }

        stage('Deploy Frontend') {
            when { expression { env.FRONTEND_CHANGED == 'true' } }
            steps {
                sh '''
                docker stop frontend_app || true
                docker rm frontend_app || true
                docker run -d -p 3001:3001 --name frontend_app $FRONTEND_IMAGE:$TAG
                '''
            }
        }
    }

    post {
        always {
            echo "Pipeline finished. Backend changed: ${env.BACKEND_CHANGED}, Frontend changed: ${env.FRONTEND_CHANGED}"
        }
    }
}