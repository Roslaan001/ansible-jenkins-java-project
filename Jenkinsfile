pipeline {
    agent any
    stages {
        stage('Copy files to ansible server') {
            steps {
                echo 'Copying files to ansible server(ansible control node).......'
                
                // Copy ansible files using ansible-server-key
                sshagent(['ansible-server-key']) {
                    sh "scp -o StrictHostKeyChecking=no -o IdentitiesOnly=yes ./ansible/* ubuntu@44.202.53.110:/home/ubuntu"
                }
                
                // Copy EC2 SSH key and set proper permissions
                withCredentials([sshUserPrivateKey(credentialsId: 'ec2-server-key', keyFileVariable: 'keyFile')]) {
                    sshagent(['ansible-server-key']) {
                        sh """
                            scp -o StrictHostKeyChecking=no -o IdentitiesOnly=yes ${keyFile} ubuntu@44.202.53.110:/home/ubuntu/ssh-key.pem
                            ssh -o StrictHostKeyChecking=no ubuntu@44.202.53.110 'chmod 400 /home/ubuntu/ssh-key.pem'
                        """
                    }
                }
            }
        }
    }
}