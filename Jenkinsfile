pipeline {
    agent any
    stages {

        stage('Clone Repo') {
          steps {
            sh 'rm -rf Jenkins-pipeline'
            sh 'git clone https://github.com/jayasurya9666/Jenkins-pipeline.git'
            }
        }
		
		stage('Packer Build AMI') {
          steps {
            
            sh 'pwd'
            sh 'ls -al'
            sh 'cp /var/lib/jenkins/workspace/Pipeline/'
            sh 'ls -al'
            sh 'packer build packer.json'
            }
        }
				
		stage('Deploy EC2 Server') {
          steps {
		    sh 'terraform init'
            sh 'terraform apply --auto-approve'
            }
        }

        stage('Build Docker Image') {
          steps {
            sh 'cd /var/lib/jenkins/workspace/pipeline'
            sh 'cp  /var/lib/jenkins/workspace/pipeline/* /var/lib/jenkins/workspace/pipeline'
            sh 'docker build -t jayasurya/pipelinetestprod:${BUILD_NUMBER} .'
            }
        }

        stage('Push Image to Docker Hub') {
          steps {
           sh    'docker push jayasurya/pipelinetestprod:${BUILD_NUMBER}'
           }
        }

        stage('Deploy to Docker Host') {
          steps {
		    sh 'sleep 10s'
            sh    'docker -H tcp://10.10.1.134:2375 stop prodwebapp1 || true'
            sh    'docker -H tcp://10.10.1.134:2375 run --rm -dit --name prodwebapp1 --hostname prodwebapp1 -p 8000:80 jayasurya/pipelinetestprod:${BUILD_NUMBER}'
            }
        }

        stage('Check WebApp Rechability') {
          steps {
          sh 'sleep 10s'
          sh ' curl http://10.10.1.134:8000'
          }
        }

    }
}
