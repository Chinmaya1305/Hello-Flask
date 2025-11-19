pipeline {
  agent any

  environment {
    ARTIFACTS_PATH = "dist/*.tar.gz"
  }

  stages {

    stage('Checkout') {
      steps {
        // If job is configured with SCM and Jenkinsfile from repo, `checkout scm` will work.
        // If using credentials for a private repo, configure credentials in Job SCM settings.
        checkout scm
      }
    }

    stage('Prepare Python') {
      steps {
        sh 'python3 --version || python --version'
        sh 'python3 -m pip --version || true'
        sh 'python3 -m pip install --user pip || true'
      }
    }

    stage('Install deps') {
      steps {
        // install into current workspace (not system)
        sh 'python3 -m pip install --upgrade -r requirements.txt'
      }
    }

    stage('Unit tests') {
      steps {
        sh 'pytest --maxfail=1 --disable-warnings -q --junitxml=reports/junit.xml'
      }
      post {
        always {
          junit 'reports/junit.xml'
        }
      }
    }

    stage('Package') {
      steps {
        sh './package.sh'
      }
    }

    stage('Archive') {
      steps {
        archiveArtifacts artifacts: "${ARTIFACTS_PATH}", fingerprint: true
      }
    }
  }

  post {
    success {
      echo "Pipeline succeeded: build ${env.BUILD_NUMBER}"
    }
    failure {
      echo "Pipeline failed: build ${env.BUILD_NUMBER}"
    }
  }
}

