pipeline {
    agent any
    stages {
        stage('scm checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/LohadeDarshan/pythoncode.git'
            }
        }
        stage('Code Validate') {
            steps {
                sh '''
                    python3 --version
                    python3 -m py_compile test.py
                '''
            }
        }
        stage('Test') {
            steps {
                sh '''
                    python3 test.py
                '''
            }
        }
        stage('Code Scan') {
            steps {
                script {
                    def scannerHome = tool 'sonar'
                    withSonarQubeEnv('sonar') {
                        sh """
                        ${scannerHome}/bin/sonar-scanner \
                        -Dsonar.projectKey=python-project \
                        -Dsonar.projectName=Python-Project \
                        -Dsonar.sources=. \
                        -Dsonar.language=py
                        """
                    }
                }
            }
        }
        stage('Build Docker Image (Python App)') {
            steps {
                sh '''
                  docker build -t myserverd/python-html-app:latest .
             '''
            }
        }
        stage('push docker image to dockerhub') {
            steps {
                withDockerRegistry(credentialsId: 'dockerHubCred', url: 'https://index.docker.io/v1/') {
                    sh 'docker push myserverd/python-html-app:latest'
                }
            }
        }
        stage('Docker Build and Run (Remote Server)') {
            steps {
                sshagent(credentials: ['DevCICD']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no root@10.153.75.210 << EOF
                        
                        docker stop python-html-app || true
                        docker rm python-html-app || true
                        
                        docker pull myserverd/python-html-app:latest

                        docker run -d --name python-html-app -p 8000:8000 python-html-app
                        EOF
                    '''
                }
            }
        }
    }
}
