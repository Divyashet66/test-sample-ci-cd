pipeline {
  agent any

	tools {
		nodejs "NodeJS"
	}
	
	
    stages {
	    stage('Scm Checkout') {
		    steps {
			    	checkout scm
		    }
	    }
	    stage('Parse Config') {
      steps {
         // Read the config.json file and parse it using jq
         sh "jq '. > config.tmp' file.json"
         // Load the values from the temporary file into environment variables
         def config = readFile 'config.tmp'
         env.PROJECT_ID = config.PROJECT_ID
         env.CLUSTER_NAME = config.CLUSTER_NAME
         env.LOCATION = config.LOCATION
         env.CREDENTIALS_ID = config.CREDENTIALS_ID
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
