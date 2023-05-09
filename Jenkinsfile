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
            when { expression { params.skip_test != false } }
            steps {
                 withSonarQubeEnv('sonar'){
                   sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=Devops-ultimate \
                   -Dsonar.java.binaries=. \
                   -Dsonar.projectKey=Devops-ultimate '''
               }
            }
        }
          stage('build docker image') {

            steps {
                sh 'docker build -t bharath0812/newrepo:5.0 .'
            }
        }
           stage('docker image scan with trivy') {
            steps {
                sh 'trivy scan bharath0812/newrepo:5.0'
            }
        }
          stage('docker image push to dockerhub') {
            steps {
                withCredentials([string(credentialsId: 'docker', variable: 'docker')]) {
    sh 'docker login -u bharath0812 -p ${docker}'
    sh 'docker push bharath0812/newrepo:5.0'

}
            }
        }
            stage('run the docker image') {
            steps {
                sh 'docker run -itd --name onlineapp -p 8081:8080 bharath0812/newrepo:5.0'
                
            }
        }
          
        }
}
