pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        echo 'Building sample...'
      }
    }
    stage('Deploy to EKS') {
      steps {
        echo 'This step assumes kubeconfig is configured and kubectl is available on the Jenkins agent.'
        sh 'kubectl apply -f k8s/deployment.yaml'
        sh 'kubectl apply -f k8s/service.yaml'
      }
    }
  }
}
