pipeline {
  agent any
  tools {maven "M2_HOME"} // M2_HOME is the variable which is mentioned in global tool
  environment {
    registry = "senthil123/forexpay"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  stages {
    stage('Cloning Git') {
      steps {
        git branch: 'master', url : 'https://github.com/salagarsprabu/ForexPay.git'
      }
    }
    stage('Build and Deploy') {
      steps {
        sh '''
        mvn clean deploy sonar:sonar -Dmaven.test.skip=true
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
