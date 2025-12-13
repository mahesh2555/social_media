pipeline {
    agent any 

    environment {
        APP_NAME    = "social_media_app"
        APP_DIR     = "/opt/${APP_NAME}"
        DEPLOY_USER = "ubuntu"
        DEPLOY_HOST = "44.213.133.82"
        JAVA_HOME   = "/usr/lib/jvm/java-21-openjdk-amd64"
        PATH        = "${JAVA_HOME}/bin:${env.PATH}"
    }

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build & Test') {
            steps {
                sh 'mvn clean test'
            }
           post {
              always {
                 junit testResults: 'target/surefire-reports/*.xml', allowEmptyResults: true
                 }
            }
        }

        stage('Package JAR') {
            steps {
                sh '''
                    mvn clean package -DskipTests
                    ls -lh target/*.jar
                '''
            }
        }

        stage('Security Scan (Trivy)') {
            steps {
                sh '''
                    trivy fs --exit-code 0 --format json \
                    --output trivy-report.json .
                '''
            }
            post {
                always {
                    archiveArtifacts artifacts: 'trivy-report.json', fingerprint: true
                }
            }
        }
        stage('Deploy to App EC2 (main only)') {
            when {
                branch 'main'
            }
            steps {
                sshagent(['92780e8f-44c7-4efa-9c57-7e888395ba60']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ubuntu@${DEPLOY_HOST} "mkdir -p /opt/social_media_app"
                        scp -o StrictHostKeyChecking=no target/*.jar ubuntu@${DEPLOY_HOST}:/opt/social_media_app/app.jar
                        ssh -o StrictHostKeyChecking=no ubuntu@${DEPLOY_HOST} "pkill -f app.jar" || true
                        ssh -o StrictHostKeyChecking=no ubuntu@${DEPLOY_HOST} "nohup java -jar /opt/social_media_app/app.jar > /opt/social_media_app/app.log 2>&1 &"
                        """

                }
            }
        }



    }

    post {
        success {
            echo "🎉 SUCCESS on branch ${env.BRANCH_NAME}"
            slackSend(
                message: "✅ SUCCESS: Job ${env.JOB_NAME} #${env.BUILD_NUMBER} on branch ${env.BRANCH_NAME}"
            )
        }
        failure {
            echo "❌ FAILED on branch ${env.BRANCH_NAME}"
        }
    }
}
message.txt
3 KB
