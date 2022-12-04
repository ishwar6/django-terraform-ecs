pipeline{
    agent any
    environment {
    AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
    AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
            }
    stages {
    
        stage('Terraform Init'){
       
      steps  {
            sh '''
            docker-compose -f devops/deploy/docker-compose.yml run --rm terraform init     
            '''}
        }
        stage('Terraform Seutp'){
            steps {
                sh '''
                docker-compose -f devops/deploy/docker-compose.yml run --rm terraform validate     
                '''
            }
        }
        stage('Terraform'){
            steps {
                sh '''
                docker-compose -f devops/deploy/docker-compose.yml run --rm terraform fmt     
                '''
            }
        }
    }
}