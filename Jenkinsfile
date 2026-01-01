pipeline {
    agent any
    stages {
        stage('scm checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/LohadeDarshan/pythoncode.git'
            }
        }
    }
}