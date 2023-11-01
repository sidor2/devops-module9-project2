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
                    echo "Incrementing the version"
                     sh "mvn build-helper:parse-version versions:set \
                         -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} \
                         -DnextSnapshot=true versions:commit"
                     def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                     def version = matcher[0][1]
                     env.IMAGE_NAME = "ilsoldier/devops:$version-${env.BUILD_NUMBER}"
                }
            }
        }

        stage("build app") {
            steps {
                script {
                    echo "Building the application..."
                    buildJar()
                }
            }
        }

        stage("build docker image") {
            steps {
                script {
                    echo "Building the docker image..."
                    buildImage(env.IMAGE_NAME)
                    dockerLogin()
                    dockerPush(env.IMAGE_NAME)
                }
            }
        }

        stage("deploy") {
            steps {
                script {
//                     echo "Deploying the application..."
//                     groovy.lang.GString dockerCmd = "docker run -d -p 8080:8080 --name myapp ${env.IMAGE_NAME}"
//                     sshagent(['ec2devopskey']) {
//                         sh "ssh -o StrictHostKeyChecking=no ec2-user@54.149.123.123 ${dockerCmd}"
//                     }
                     echo 'deploying docker image to EC2...'

                     groovy.lang.GString shellCmd = "bash ./server-cmds.sh ${env.IMAGE_NAME}"
                     def ec2Instance = "ec2-user@54.149.123.123"

                     sshagent(['ec2devopskey']) {
                         sh "scp server-cmds.sh ${ec2Instance}:/home/ec2-user"
                         sh "scp docker-compose.yaml ${ec2Instance}:/home/ec2-user"
                         sh "ssh -o StrictHostKeyChecking=no ${ec2Instance} ${shellCmd}"
                     }
                }
            }
        }

        stage("commit version update") {
            steps {
                script {
                    echo "Committing the version update..."
                    commitToGithub("2c40c606-3564-4fc4-8fc2-3a89a016f089","devops-module9-project2","starting-code")
                }
            }
        }
    }
} 
