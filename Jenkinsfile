pipeline {
    agent any
    stages{
        stage("checkout"){
            steps{
                checkout scm
            }
        }

        stage("Test"){
            steps{
                sh 'sudo apt install npm -y'
                sh 'npm test'
            }
        }

        stage("Build"){
            steps{
                sh 'npm run build'
            }
        }

        stage("Build Image"){
            steps{
                sh 'sudo docker build -t my-node-app:1.0 .'
            }
        }
        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker_cred', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                    sh 'sudo docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD'
                    sh 'sudo docker tag my-node-app:1.0 adinugroho251/my-node-app:1.0'
                    sh 'sudo docker push adinugroho251/my-node-app:1.0'
                    sh 'sudo docker logout'
                }
            }
        }

      stage('Docker RUN') {
          steps {
      	     sh 'docker run -d -p 6969:3000 --name webserver-devopsgol  adinugroho251/my-node-app:1.0 .'
      }
    }
 }
}    
    
