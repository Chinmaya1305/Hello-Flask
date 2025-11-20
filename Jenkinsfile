pipeline {
  agent any
  environment {
    REGISTRY = "localhost:10090"
    IMAGE = "${env.REGISTRY}/hello-flask"
    TAG = "latest"
    K8S_MANIFEST = "k8s"
  }
  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Unit tests') {
      steps {
        sh '''
          set -e
          if [ -f tests/run_tests.sh ]; then
            bash tests/run_tests.sh
          else
            echo "No tests found, skipping unit tests"
          fi
        '''
      }
    }

    stage('Build image') {
      steps {
        sh "docker --version || true"
        sh "docker build -t ${IMAGE}:${TAG} ."
      }
    }

    stage('Push image') {
      steps {
        sh "docker push ${IMAGE}:${TAG}"
      }
    }

    stage('Deploy to cluster') {
      steps {
        sh "kubectl apply -f ${K8S_MANIFEST} || true"
        sh "kubectl rollout status deployment/hello-flask --timeout=120s || true"
      }
    }
  }

  post {
    success {
      echo "Pipeline finished successfully"
    }
    failure {
      echo "Pipeline failed — check console output"
    }
  }
}

