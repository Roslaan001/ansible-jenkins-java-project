pipeline {
    agent any
    stages {
        stage('Copy files to ansible server') {
            steps {
                echo 'Copying files to ansible server(ansible control node).......'
                sshagent(['ansible-server-key']) {
                    sh "scp -o StrictHostKeyChecking=no -o IdentitiesOnly=yes ./ansible/* ubuntu@44.202.53.110:/home/ubuntu"

                    withCredentials([sshUserPrivateKey(credentialsId: 'ec2-server-key', keyFileVariable: 'keyFile', usernameVariable: 'user')]) {
                        sh "scp -o StrictHostKeyChecking=no -o IdentitiesOnly=yes ${keyFile} ubuntu@44.202.53.110:/home/ubuntu/ssh-key.pem"
                    }
                }

            }
        }
    }
}