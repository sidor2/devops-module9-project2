#!/usr/bin.env groovy

pipeline {   
    agent any
    stages {
        stage("test") {
            steps {
                script {
                    echo "Testing the application..."

                }
            }
        }
        stage("build") {
            steps {
                script {
                    echo "Building the application..."
                }
            }
        }

        stage("deploy") {
            steps {
                script {
                    def dockerCmd = "docker run -d -p 8080:3080 --name myapp ilsoldier/devops:m9-node-app"
                    sshagent(['ec2devopskey']) {
                        ssh "ssh -o StrictHostKeyChecking=no ec2-user@34.222.11.193 ${dockerCmd}}"
                    }
                }
            }
        }               
    }
} 
