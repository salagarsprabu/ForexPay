pipeline {
  environment {
    registry = "senthil123/forexpay"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
      agent any
  stages {
    stage('Cloning Git') {
      steps {
        git branch: 'master', url : 'https://github.com/salagarsprabu/ForexPay.git'
      }
    }
    stage('Build and Deploy') {
      agent{
                docker {
                    image 'maven:3-alpine' 
                    args '-v /root/.m2:/root/.m2' 
                }
            }
      steps {
        sh '''
        mvn clean package sonar:sonar -Dmaven.test.skip=true
        cd ..
        tar -czvf $JOB_NAME.tar.gz $JOB_NAME
        cp -f $JOB_NAME.tar.gz $WORKSPACE/
        '''
      }
    }   
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
}
