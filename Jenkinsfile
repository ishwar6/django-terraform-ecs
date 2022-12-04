pipeline{
    agent any
  
    stages {
    
        stage('Terraform Init'){
       
      steps  {

               withCredentials([aws(credentialsId: 'b62a4ab2-5a62-4b83-b92e-025b080bc4e1', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
            sh '''
            docker-compose -f devops/deploy/docker-compose.yml run --rm terraform init     
            '''
        }

   }
        }
        stage('Terraform Seutp'){
            steps {
                     withCredentials([aws(credentialsId: 'b62a4ab2-5a62-4b83-b92e-025b080bc4e1', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh '''
                        docker-compose -f devops/deploy/docker-compose.yml run --rm terraform validate     
                        '''
        }
            }
        }
        stage('Terraform'){
            steps {
                    withCredentials([aws(credentialsId: 'b62a4ab2-5a62-4b83-b92e-025b080bc4e1', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh '''
                        docker-compose -f devops/deploy/docker-compose.yml run --rm terraform fmt     
                        '''
        }
            }
        }
    }
}