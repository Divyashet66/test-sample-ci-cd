pipeline {
  agent any
	
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

	    
	     stage('Build') {
            steps {
                // Use Docker to build the PHP application
                // Ensure Docker is installed on the Jenkins agent
                script {
                    docker.build("my-php-app:${env.BUILD_ID}", "-f Dockerfile .")
                }
            }
        }
	    
	    stage("Push Docker Image") {
		    steps {
			    script {
				    echo "Push Docker Image"
				        sh 'gcloud auth configure-docker us-central1-docker.pkg.dev'
				        sh "sudo docker push us-central1-docker.pkg.dev/tech-rnd-project/network18/php"
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
			    // sh 'helm install helm_chart_name helm'
			    step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'deployment-folder', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
			    echo "Deployment Finished ..."
			    sh '''
			    '''
		    }
	    }
    }
}
