pipeline {
    agent any
    stages {
        stage('Copy files to ansible server') {
            steps {
                echo 'Copying files to ansible server(ansible control node).......'
                sshagent(['ansible-server-key']) {
                    sh "scp -o StrictHostKeyChecking=no ./ansible/* ubuntu@44.203.203.102:/home/ubuntu"

                    withCredentials([sshUserPrivateKey(credentialsId: 'ec2-server-key', keyFileVariable: 'keyFile', usernameVariable: 'user')]) {
                        sh "scp StrictHostKeyChecking=no ${keyFile} ubuntu@44.203.203.102:/home/ubuntu/ssh-key.pem"
                    }
                }

            }
        }
    }
}