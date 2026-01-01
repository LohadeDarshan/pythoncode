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
                withSonarQubeEnv(credentialsId: 'sonar-token', installationName: 'sonar') {
                    sh 'sonar-scanner'
                }
            }
        }
    }
}
