pipeline{
    agent any
    tools {
        terraform 'terraform'
    }
     environment {
        AWS_ACCESS_KEY_ID     = credentials('00fa2e45-1139-4f2a-b35e-fc97753abe81')
        AWS_SECRET_ACCESS_KEY = credentials('115fa418-1064-46ca-b9e7-2fae5f4c27fd')
        docker_hub_pass=credentials('3ec137a3-1661-49ea-9b4e-6874ec7ccd40')
    }
    stages{
        stage("scm check"){
            steps{
                git 'https://github.com/abhishekverma108/terraform_jenkins.git'
            }
        }
        stage("Creating Instance on Aws From Terraform"){
            steps{
                sh 'sudo terraform init'
                sh 'sudo terraform apply -auto-approve'
            }
        }
        
        stage("Kubernetes Cluster Setup on Aws From Ansible"){
            steps{
                
                sh 'export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID'
                sh 'export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY'
                ansiblePlaybook credentialsId: 'privatekey', disableHostKeyChecking: true, installation: 'ansible', inventory: 'aws_ec2.yml', playbook: 'yum_aws.yml'
                
            }
        }
        stage("Building Docker Image From Docker File"){
            steps{
                
                sh 'docker build -t abhishekverma109/app:latest .'
            }
        }
        stage("Pushing Docker Image to Dockerhub"){
            steps{
                sh 'docker login -u abhishekverma109 -p ${docker_hub_pass}'
                sh 'docker push  abhishekverma109/app:latest'
            }
        }
        stage("Deploying webapp on k8s cluster"){
            steps{
                ansiblePlaybook credentialsId: 'privatekey', disableHostKeyChecking: true, installation: 'ansible', inventory: 'aws_ec2.yml', playbook: 'ansible_k8s.yml'                

            }
        }
    }
}
