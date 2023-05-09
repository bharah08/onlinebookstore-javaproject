pipeline {
    agent any
    tools{
        maven 'maven'
    }
    

    stages {
        stage('github') {
            steps {
                git 'https://github.com/bharah08/onlinebookstore-javaproject.git'
            }
        }
         stage('code compile') {
            steps {
                sh 'mvn compile'
            }
        }
         stage('unit test') {
            steps {
                sh 'mvn test'
            }
        }
         stage('build code') {
            steps {
                sh 'mvn clean install'
            }
        }
          
        }
   post {
  always {
    slackSend channel: 'dev', message: "please find the status of build started ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}"
  }
}
}
