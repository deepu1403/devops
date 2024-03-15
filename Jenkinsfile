pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout your source code repository
                #git 'https://github.com/deepu1403/devops.git'
            }
        }
        
        stage('Build') {
            steps {
                // Execute your build process here
                sh 'mvn clean install'
            }
        }
        
        stage('Test') {
            steps {
                // Execute your tests
                sh 'mvn test'
            }
        }
        
        stage('Static Code Analysis') {
            steps {
                // Execute static code analysis tools
                sh 'sonar-scanner'
            }
        }
        
        stage('Deploy') {
            steps {
                // Deploy your application
                sh 'ansible-playbook deploy.yml'
            }
        }
        
        stage('Post Deployment Tests') {
            steps {
                // Execute tests after deployment
                sh 'npm run test'
            }
        }
        
        stage('Notify') {
            steps {
                // Send notifications or alerts
                echo 'Deployment completed successfully'
            }
        }
    }
    
    // Define post actions (e.g., cleanup)
    post {
        success {
            // Cleanup actions on success
            echo 'Pipeline executed successfully'
        }
        failure {
            // Actions to take on failure
            echo 'Pipeline failed'
        }
    }
}