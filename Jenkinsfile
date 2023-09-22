// pipeline {
//     agent any
//     environment {
//     AWS_ACCOUNT_ID="398767507008"
//     AWS_DEFAULT_REGION="us-east-1" 
//     IMAGE_REPO_NAME="apiapp"
//     IMAGE_TAG="latest"
//     REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
//     }
 
//     stages {
//         stage('Logging into AWS ECR') {
//             steps {
//                 script {
//                     sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
//                         }
//                     }
//                 }
 
//         stage('Cloning Git') {
//             steps {
//                 checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/sd031/aws_codebuild_codedeploy_nodeJs_demo.git']]]) 
//                 }
//             }
 
//  // Building Docker images
//         stage('Building image') {
//             steps{
//                 script {
//                     dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
//                 }
//             }
//         }
 
//  // Uploading Docker images into AWS ECR
//         stage('Pushing to ECR') {
//             steps{ 
//                 script {
//                     sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:$IMAGE_TAG"
//                     sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
//                 }
//             }
//         }
//     }
// }

def label = "docker-${UUID.randomUUID().toString()}"
AWS_ACCOUNT_ID="398767507008"
AWS_DEFAULT_REGION="us-east-1" 
IMAGE_REPO_NAME="apiapp"
IMAGE_TAG="latest"
REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
REGISTRY_CREDENTIALS = "aws-credentials"

podTemplate(label: label, yaml: """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: docker
    image: docker:stable-dind
    securityContext:
      privileged: true
    env:
    - name: DOCKER_TLS_CERTDIR
      value: ""
  volumes:
  - name: workspace
    emptyDir: {}
"""  ) {

  def image = "jenkins/jnlp-slave"
  node(label) {
    stage('Build Docker image') {
      git 'https://github.com/dzmarat/terraform-eks.git'
      container('docker') {
        sh """cd app
            docker build -t ${image} ."""
      }
    }
    // stage('Install AWS CLI') {
    //   container('docker') {
    //     // Install AWS CLI using pip (Python package manager)
    //     sh """
    //       curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    //       unzip awscliv2.zip
    //       sudo ./aws/install
    //       """
    //   }
    // }
    // stage('Login to ECR') {
    //   container('docker') {
    //     sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
    //   }
    // }
      stage('Deploy image') {
        steps{
            script{
                docker.withRegistry("https://" + REPOSITORY_URI, "ecr:us-east-1:" + REGISTRY_CREDENTIALS) {
                    dockerImage.push()
                }
            }
        }
    }
  }
}