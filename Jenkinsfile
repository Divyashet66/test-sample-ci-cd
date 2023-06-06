pipeline {
  agent any

	tools {
		nodejs "NodeJS"
	}
	
	environment {
		
		        PROJECT_ID = "inframod-nw18-svc-cnt-poc"
				CLUSTER_NAME = "gke-nw18-prod-01"
				LOCATION = "asia-south1-a"
				CREDENTIALS_ID = "inframod-nw18-svc-cnt-poc"			
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
			      sh 'sudo pack build nw18-poc --builder paketobuildpacks/builder:full'
				sh 'sudo docker tag nw18-poc asia-south1-docker.pkg.dev/inframod-nw18-svc-cnt-poc/nw18-poc/nw18-poc:latest'
			    
		    }
	    }
	    
	    stage("Push Docker Image") {
		    steps {
			    script {
				    echo "Push Docker Image"
// 				    	sh 'sudo gcloud auth list'
// 				        sh  'gcloud auth configure-docker asia-south1-docker.pkg.dev'
				        sh 'cat /home/prashant_c/keyfile.json | docker login -u _json_key_base64 --password-stdin https://asia-south1-docker.pkg.dev'
				        sh "sudo docker push asia-south1-docker.pkg.dev/inframod-nw18-svc-cnt-poc/nw18-poc/nw18-poc:latest"
				    
					sh 'curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl'

					sh "chmod +x kubectl"

					sh "sudo mv kubectl \$(which kubectl)"

				    
			    }
		    }
	    }
	    
	    stage('Deploy to K8s') {
		    steps{
			    echo "Deployment started ..."
			    sh 'ls -ltr'
			    sh 'pwd'
				
				echo "Start deployment of deployment.yaml"
				step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'k8', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
			    	echo "Deployment Finished ..."
			    sh '''
			    '''
			    
		    }
	    }
    }
}
