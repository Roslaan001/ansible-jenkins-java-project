pipeline {
    agent any
    stages {
        stage('Copy files to ansible server') {
            steps {
                echo 'Copying files to ansible server (ansible control node).......'
                
                sshagent(['ansible-server-key']) {
                    // Test SSH
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@44.202.53.110 'echo ✅ Connected to Ansible Server'"

                    // Copy ansible files
                    sh "scp -o StrictHostKeyChecking=no ./ansible/* ubuntu@44.202.53.110:/home/ubuntu"

                    // Copy EC2 key as ssh-key.pem
                    sh """
                        scp -o StrictHostKeyChecking=no ${SSH_AUTH_SOCK} ubuntu@44.202.53.110:/home/ubuntu/ssh-key.pem
                        ssh -o StrictHostKeyChecking=no ubuntu@44.202.53.110 'chmod 400 /home/ubuntu/ssh-key.pem'
                    """
                    
                }
            }
        }
    }
}
