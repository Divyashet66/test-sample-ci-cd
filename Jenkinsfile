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
      config_data = sh(script: "jq '.' file.json", returnStdout: true).trim()
      // Convert the JSON string to a Groovy map
      def config = readJSON text: config_data
   }

   stage('Set Environment Variables') {
      // Set the environment variables based on the values in the config file
      env.PROJECT_ID = config.PROJECT_ID
      env.CLUSTER_NAME = config.CLUSTER_NAME
      env.LOCATION = config.LOCATION
      env.CREDENTIALS_ID = config.CREDENTIALS_ID
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
