pipeline {
    agent any
    stages {
        stage('Copy files to ansible server') {
            steps {
                echo 'Copying files to ansible server (ansible control node).......'
                
                // Test ssh connection and Copy ansible playbooks using ansible-server-key
                sshagent(['ansible-server-key']) {
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@44.202.53.110 'echo ✅ Connected to Ansible Server'"
                    sh "scp -o StrictHostKeyChecking=no ./ansible/* ubuntu@44.202.53.110:/home/ubuntu"
                }

                // Copy the same private key but under a new name on the server
                withCredentials([sshUserPrivateKey(credentialsId: 'ansible-server-key', keyFileVariable: 'PRIVATE_KEY')]) {
                    sshagent(['ansible-server-key']) {
                        sh """
                            scp -o StrictHostKeyChecking=no ${PRIVATE_KEY} ubuntu@44.202.53.110:/home/ubuntu/ssh-key.pem
                            ssh -o StrictHostKeyChecking=no ubuntu@44.202.53.110 'chmod 400 /home/ubuntu/ssh-key.pem'
                        """
                    }
                }
            }
        }
    }
}
