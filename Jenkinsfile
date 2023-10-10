pipeline {
    agent any
    environment {
    AWS_ACCOUNT_ID="398767507008"
    AWS_DEFAULT_REGION="us-east-1" 
    IMAGE_REPO_NAME="apiapp"
    IMAGE_TAG="latest"
    REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }
 
    stages {
      when {
              expression {
                currentBuild.changeSets.size() > 0 &&
                currentBuild.changeSets[0].pullRequest &&
                currentBuild.changeSets[0].pullRequest.targetBranch == 'master'
              }
            }
      stage {
        script {
          sh "echo hello world"
      }
    }
  }
}

// def label = "docker-${UUID.randomUUID().toString()}"
// AWS_ACCOUNT_ID="398767507008"
// AWS_DEFAULT_REGION="us-east-1" 
// IMAGE_REPO_NAME="apiapp"
// IMAGE_TAG="latest"
// REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"

// podTemplate(label: label, yaml: """
// apiVersion: v1
// kind: Pod
// spec:
//   containers:
//   - name: docker
//     image: docker:stable-dind
//     securityContext:
//       privileged: true
//     env:
//     - name: DOCKER_TLS_CERTDIR
//       value: ""
//   volumes:
//   - name: workspace
//     emptyDir: {}
// """  ) {

//   def image = "jenkins/jnlp-slave"
//   node(label) {
//     stage('Build Docker image') {
//       git 'https://github.com/dzmarat/terraform-eks.git'
//       container('docker') {
//         sh """cd app
//             docker build -t ${image} ."""
//       }
//     }
//     stage('test branch') {
//       git 'https://github.com/dzmarat/terraform-eks.git'
//       container('docker') {
//         sh """env"""
//       }
//     }
//     stage('echo') {
//       git 'https://github.com/dzmarat/terraform-eks.git'
//       container('docker') {
//         sh """echo helloooooooo world"""
//       }
//     }

//     // stage('Install AWS CLI') {
//     //   container('docker') {
//     //     // Install AWS CLI using pip (Python package manager)
//     //     sh """
//     //       apk add curl
//     //       curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
//     //       unzip awscliv2.zip
//     //       ./aws/install
//     //       """
//     //   }
//     // }
//     // stage('Login to ECR') {
//     //   container('docker') {
//     //     sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
//     //   }
//     // }
//   }
// }

