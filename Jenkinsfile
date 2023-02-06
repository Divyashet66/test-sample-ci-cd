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
	    
	    
	    stage('Deploy to K8s') {
		    steps{
			    echo "Deployment started ..."
			    sh 'ls -ltr'
			    sh 'pwd'
				
				echo "Start deployment of deployment.yaml"
			    step([$class: 'KubernetesEngineBuilder', projectId: ${PROJECT_ID}, clusterName: ${CLUSTER_NAME}, location: ${LOCATION}, manifestPattern: 'k8', credentialsId: ${CREDENTIALS_ID}, verifyDeployments: true])
			    	echo "Deployment Finished ..."
			    sh '''
			    '''
			    
		    }
	    }
    }
}
