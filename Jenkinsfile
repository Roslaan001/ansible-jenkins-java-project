/* groovylint-disable DuplicateListLiteral, DuplicateStringLiteral */
pipeline {
    agent any
    stages {
        stage('Copy files to ansible server') {
            steps {
                echo 'Copying files to ansible server (ansible control node).......'
                
                // Test ssh connection and Copy ansible playbooks using ansible-server-key
                sshagent(['ansible-server-key']) {
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@44.202.53.110 'echo ✅ Connected to Ansible Server'"
                    sh 'scp -o StrictHostKeyChecking=no ./ansible/* ubuntu@44.202.53.110:/home/ubuntu'
                }

                // Copy the same private key but under a new name on the server
                withCredentials([
                    sshUserPrivateKey(
                        credentialsId: 'ansible-server-key',
                        keyFileVariable: 'PRIVATE_KEY'
                    )
                ]) {
                    sshagent(['ansible-server-key']) {
                            // scp -o StrictHostKeyChecking=no $PRIVATE_KEY ubuntu@44.202.53.110:/home/ubuntu/ssh-key.pem
                        sh '''
                            ssh -o StrictHostKeyChecking=no ubuntu@44.202.53.110 'chmod 400 /home/ubuntu/ssh-key.pem'
                        '''
                    }
                }
            }
        }

        stage("Run the ansible playbook in the ec2 instance(remote server)") {
            steps {
                script {
                    echo "Calling the ansible playbook to configure the ec2 instances"
                    def remote = [:]
                    remote.name = "ansible-server"
                    remote.host = '44.202.53.110'
                    remote.allowAnyHosts = true

                    withCredentials([
                        sshUserPrivateKey(
                            credentialsId: 'ansible-server-key',
                            keyFileVariable: 'PRIVATE_KEY'
                        )
                    ]) {
                        remote.user = 'ubuntu'
                        remote.identityFile = PRIVATE_KEY
                        sshCommand remote: remote, command: "ansible-playbook my-playbook.yml"
                }
            }
        }
    }
}
}
