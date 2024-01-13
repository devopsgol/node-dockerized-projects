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
                sh 'sudo docker build -t my-node-app:latest .'
            }
        }
        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker_cred', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                    sh 'sudo docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD'
                    sh 'sudo docker tag my-node-app:latest adinugroho251/my-node-app:latest'
                    sh 'sudo docker push adinugroho251/my-node-app:latest'
                    sh 'sudo docker logout'
                }
            }
        }

      stage('Docker RUN') {
          steps {
      	     sh 'sudo docker run -d -p 80 --name deploy-apps-nodejs-devopsgol  adinugroho251/my-node-app:latest'
      }
    }
}    
}
    
