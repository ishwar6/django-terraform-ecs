pipeline{
    agent any
    stages {
    
        stage('Terraform Init'){
       
      steps  {
            sh '''
            docker-compose -f deploy/docker-compose.yml run --rm terraform init     
            '''}
        }
        stage('Terraform Seutp'){
            steps {
                sh '''
                docker-compose -f deploy/docker-compose.yml run --rm terraform validate     
                '''
            }
        }
        stage('Terraform'){
            steps {
                sh '''
                docker-compose -f deploy/docker-compose.yml run --rm terraform fmt     
                '''
            }
        }
    }
}