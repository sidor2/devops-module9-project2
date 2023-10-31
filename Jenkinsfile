#!/usr/bin/env groovy
// @Library('jenkins-shared-library')

library identifier: 'jenkins-shared-library@main', retriever: modernSCM(
    [$class: 'GitSCMSource',
     remote: 'git@github.com:sidor2/devops-module8-jenkins-shared-lib.git',
     credentialsId: '2c40c606-3564-4fc4-8fc2-3a89a016f089',
    ]
)

pipeline {   
    agent any

    tools {
        maven 'maven-3.9'
    }

    stages {
        stage("test") {
            steps {
                script {
                    echo "Testing the application..."

                }
            }
        }
        stage("increment version") {
            steps {
                script {
                    updateIncrementalVersionMaven()
                }
            }
        }
        stage("build app") {
            steps {
                script {
                    echo "Building the application..."
                }
            }
        }

        stage("build docker image") {
            steps {
                script {
                    echo "Building the docker image..."
                }
            }
        }
        stage("deploy") {
            steps {
                script {
                    def dockerCmd = "docker run -d -p 8080:8080 --name myapp ilsoldier/devops:"
                    sshagent(['ec2devopskey']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@54.185.51.167 ${dockerCmd}"
                    }
                }
            }
        }
        stage("commit version update") {
            steps {
                script {
                    echo "Committing the version update..."
                }
            }
        }
    }
} 
