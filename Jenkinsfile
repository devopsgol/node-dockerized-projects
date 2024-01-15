pipeline {
    agent {
           label 'slave-devopsgol'
    }
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

        stage("Build NPM"){
            steps{
                sh 'npm run build'
            }
        }

        stage('Scan') {
            steps{
                snykSecurity organisation: 'devopsgol', projectName: 'synk-apps-to-html-devopsgol', severity: 'medium', snykInstallation: 'synk-devopsgol', snykTokenId: 'ca7f504e-fa39-4565-8064-369f9f7f51a8', targetFile: 'package.json'
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
      	     sh 'sudo docker run -d -p 3000 --name deploy-apps-nodejs-devopsgol-test-successfully  adinugroho251/my-node-app:latest'
      }
    }
}    
}
    
