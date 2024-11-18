pipeline {
    agent { label 'ajay' }
    stages {
        stage('clean workspace'){
            steps{
                cleanWs()
            }
        }
        stage('Checkout from Git'){
            steps{
                git branch: 'main', url: 'https://github.com/ajaymaddela/spring-petclinic-2024-03.git'
            }
        }
        stage('build') {
            steps {
                sh 'mvn clean package'
                // junit testResults: '**/surefire-reports/*.xml'
            }
        }
        
        stage('Build docker image') {
            steps {
                sh "docker image build -t ajaykumar020/spc:1.0 ."
            }
        }
        // stage('Trivy Scan') {
        //     steps {
        //         script {
        //             sh "trivy image --format json -o trivy-report.json ajaykumar020/spc:1.0"
        //         }
        //          archiveArtifacts artifacts: 'trivy-report.json', allowEmptyArchive: true
        //     }
        // }
        // stage('publish docker image') {
        //     steps {
        //         sh "docker image push ajaykumar020/spc:1.0"
        //     }
        // }
        
        stage('Terraform Init') {
            steps {
                dir('deployment/terraform') {
                    sh 'terraform init'
                    
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('deployment/terraform') {
                    script {
                        sh 'terraform plan'
                    }
                }
            }
        }

        stage('Terraform Apply or Destroy') {
            steps {
                dir('deployment/terraform') {
                    script {
                        // sh 'sudo apt-get update && sudo apt-get install -y jq'
                        // // Check if resource group already exists
                        // def exists = sh(script: 'terraform show -json | jq \'.values.root_module.resources[] | select(.type == "azurerm_resource_group") | .values.name\'', returnStdout: true).trim()

                        // if (exists) {
                        //     // Destroy existing resource group
                        //     sh 'terraform destroy -auto-approve'
                        // }

                        // Apply Terraform configuration
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
    
        stage('deploy to k8s') {
            steps {
                sh "kubectl apply -f deployment/k8s/spc.yaml"
                sh """
                kubectl patch deployment spc -p '{"spec":{"template":{"spec":{"containers":[{"name":"spc","image":"ajaykumar020/spc:1.0"}]}}}}'
                """
            }
        }

        // stage('kubescape Scan') {
        //     steps {
        //         script {
        //             sh "/usr/local/bin/kubescape scan -t 40 deployment/k8s/spc.yaml --format junit -o TEST-report.xml"
        //             junit "**/TEST-*.xml"
        //         }
                
        //     }
        // }
    }
}
