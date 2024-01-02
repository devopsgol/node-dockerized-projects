pipeline {
    agent any
    stages{
        stage("checkout"){
            steps{
                checkout scm
            }
        }

        stage("Test"){
            steps {
                script {
                    sh "sudo apt install npm -y"
                    sh "npm test"
            }
        }
    }

        stage("Build"){
            steps{
                script {
                    sh "npm run build"
            }
        }
    }

        stage("Build Image"){
            steps{
                script {
                docker.build("${imagename}:latest", ".")
            }
        }
    }
        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker_cred', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                    script {
                        sh "sudo docker login --password-stdin -u $dockerHubUser -p $dockerHubPassword"
                        sh "sudo docker push ${imagename}:latest"
                        sh "sudo docker rmi ${imagename}:latest"
                }
            }
        }
    }
}
}
