pipeline{
    
    agent{
        node{
            label 'maven'
        }
    }

environment {
    PATH = "/opt/apache-maven-3.9.8/bin:$PATH"
    BUILD_NUMBER = "${env.BUILD_NUMBER ?: 'latest'}"
    registry = 'https://registry.hub.docker.com'
    DOCKERHUB_CREDENTIALS = credentials('docker-hub')
}

stages {
        stage('Build') {
            steps {
                echo "----------------------build  started-------------"
                sh 'mvn clean deploy -Dmaven.test.skip=true'
                echo "----------------------build  completed-------------"
            }
       }
       stage('test'){
            steps{
                echo "----------------------unit test started-------------"
                sh 'mvn surefire-report:report'
                echo "----------------------unit test completed------------"
            }
        }

        stage('Build Docker image'){
            steps{
                script{
                    echo "-----------------docker build started--------------"
                     sh 'docker build -t bunty4200/iqm_javaapp:${BUILD_NUMBER} .'
                    echo "-----------------docker build completed------------"
                }
            }  
        }

        stage('login to dockerhub') {
            steps{
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('push image'){
            steps{
                sh 'docker push bunty4200/iqm_javaapp:${BUILD_NUMBER}'
        }
    }

    }
}

