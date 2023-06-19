pipeline {
  agent any

	tools {
		nodejs "NodeJS"
	}
	
	environment {
		
		    PROJECT_ID = "tech-rnd-project"
            CLUSTER_NAME = "network18-cluster"
            LOCATION = "us-central1-a"
            CREDENTIALS_ID = "kubernetes"				
	}
	
    stages {
	    stage('Scm Checkout') {
		    steps {
			    	checkout scm
		    }
	    }
	    stage('build') {
              steps {
                  echo 'building the software'
                  sh 'npm install --force'
              }
          }

	    
	    stage('Build Docker Image') {
		    steps {
			    sh 'whoami'
			    sh 'sudo chmod 777 /var/run/docker.sock'
			    sh ' sudo apt update'
 			    sh 'sudo apt install software-properties-common -y'    
				sh 'sudo add-apt-repository ppa:cncf-buildpacks/pack-cli'
 				sh 'sudo  apt-get update'
 				sh 'sudo apt-get install pack-cli'
			    sh 'pack build node --builder gcr.io/buildpacks/builder:google-22'
				sh 'docker tag node us-central1-docker.pkg.dev/tech-rnd-project/network18/node:standard'
			    
		    }
	    }
	    
	    stage("Push Docker Image") {
		    steps {
			    script {
				    echo "Push Docker Image"
				        sh 'gcloud auth configure-docker us-central1-docker.pkg.dev'
				        sh "sudo docker push us-central1-docker.pkg.dev/tech-rnd-project/network18/node:standard"
                        sh 'curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl'
                        sh "chmod +x kubectl"
                        sh "sudo mv kubectl \$(which kubectl)"
			    }
		    }
	    }
	    
	    stage('Deploy to K8s using helm') {
		    steps{
			    echo "Deployment started ..."
			    sh 'ls -ltr'
			    sh 'pwd'
			    sh "gcloud container clusters get-credentials ${CLUSTER_NAME} --zone ${LOCATION} --project ${PROJECT_ID}"
			    sh 'helm install node1 helm'
			    echo "Deployment Finished ..."
			    sh '''
			    '''
		    }
	    }
    }
}