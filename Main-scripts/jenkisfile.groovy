pipeline {
    agent any
    environment {
        BUCKET_NAME = "backup-bucket"
        BACKUP_KEY = "backup.tar"
        BACKUP_PATH = "/tmp/backup.tar"
        AWS_REGION = "us-east-1"
        DOCKER_IMAGE = "php:7.4-apache"
    }
    stages {
        stage('Download backup from S3') {
            steps {
                sh "aws s3 cp s3://${BUCKET_NAME}/${BACKUP_KEY} ${BACKUP_PATH} --region ${AWS_REGION}"
            }
        }
        stage('Extract backup') {
            steps {
                sh "tar -xf ${BACKUP_PATH} -C /tmp/"
            }
        }
        stage('Copy PHP file to container') {
            steps {
                sh "docker cp /tmp/index.php $(docker ps -q):/var/www/html/index.php"
            }
        }
        stage('Restart container') {
            steps {
                sh "docker restart $(docker ps -q)"
            }
        }
    }
}
