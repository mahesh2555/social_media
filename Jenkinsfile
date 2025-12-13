pipeline {
    agent any

    environment {
        APP_NAME     = "social_media_app"
        APP_DIR      = "/opt/${APP_NAME}"
        DEPLOY_USER  = "ubuntu"
        DEPLOY_HOST  = "44.213.133.82"

        // Your Tomcat is installed as a service and uses this webapps path:
        TOMCAT_WEBAPPS = "/var/lib/tomcat10/webapps"

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
                sh 'mvn -B clean test'
            }
            post {
                always {
                    // Don’t fail if there are no tests yet
                    junit testResults: 'target/surefire-reports/*.xml', allowEmptyResults: true
                }
            }
        }

        stage('Package WAR') {
            steps {
                sh '''
                    mvn -B clean package -DskipTests
                    ls -lh target/*.war
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
            when { branch 'main' }
            steps {
                sshagent(['92780e8f-44c7-4efa-9c57-7e888395ba60']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${DEPLOY_USER}@${DEPLOY_HOST} 'mkdir -p ${APP_DIR}'

                        # Copy WAR to app folder (keep a backup)
                        scp -o StrictHostKeyChecking=no target/*.war ${DEPLOY_USER}@${DEPLOY_HOST}:${APP_DIR}/Social-Media.war

                        # Deploy WAR into Tomcat10 webapps and restart tomcat10 service
                        ssh -o StrictHostKeyChecking=no ${DEPLOY_USER}@${DEPLOY_HOST} '
                          sudo cp ${APP_DIR}/Social-Media.war ${TOMCAT_WEBAPPS}/Social-Media.war &&
                          sudo rm -rf ${TOMCAT_WEBAPPS}/Social-Media &&
                          sudo systemctl daemon-reload || true &&
                          sudo systemctl restart tomcat10 &&
                          sudo systemctl is-active --quiet tomcat10
                        '
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
