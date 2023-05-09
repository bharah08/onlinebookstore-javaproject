pipeline {
    agent any
     parameters {
        booleanParam(name: 'skip_test', defaultValue: false, description: 'Set to true to skip the test stage')
    }
    tools{
        maven 'maven'
    }
     environment{
        SCANNER_HOME= tool 'sonar'
    }

    stages {
        stage('github') {
            steps {
                git 'https://github.com/bharah08/onlinebookstore-javaproject.git'
            }
        }
         stage('code compile') {
            when { expression { params.skip_test != false } }
            steps {
                sh 'mvn compile'
            }
        }
         stage('unit test') {
            when { expression { params.skip_test != false } }
            steps {
                sh 'mvn test'
            }
        }
         stage('build code') {
            when { expression { params.skip_test != false } }
            steps {
                sh 'mvn clean install'
            }
        }
         stage('scancode with sonarqube') {
            steps {
                 withSonarQubeEnv('sonar'){
                   sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=Devops-ultimate \
                   -Dsonar.java.binaries=. \
                   -Dsonar.projectKey=Devops-ultimate '''
               }
            }
        }
          
        }
   post {
  always {
    slackSend channel: 'dev', message: "please find the status of build started ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}"
  }
}
}
