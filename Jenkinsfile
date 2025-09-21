pipeline {
    agent any

    options {
        buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws_infra_tf_533267238276')
        AWS_SECRET_ACCESS_KEY = credentials('aws_infra_tf_533267238276')
    }

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Auto-approve Terraform apply')
    }

    stages {
        stage('Terraform Version') {
            steps {
                sh 'terraform --version'
            }
        }
        stage('Terraform Format') {
            steps {
                sh 'terraform fmt -check -recursive'
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -destroy  -var-file=terraform.tfvars -out=tfplan.txt'
            }
        }
        stage('Approval') {
            when {
                not { equals expected: true, actual: params.autoApprove }
            }
            steps {
                script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Do you want to apply the plan?",
                          parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform destroy -auto-approve tfplan.txt'
            }
        }
    }
}
