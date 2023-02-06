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
				step([$class: 'KubernetesEngineBuilder', projectId: "tech-rnd-project", clusterName: "network18-cluster", location: "us-central1-a", manifestPattern: 'k8', credentialsId: "kubernetes", verifyDeployments: true])
			    	echo "Deployment Finished ..."
			    sh '''
			    '''
			    
		    }
	    }
    }
}
