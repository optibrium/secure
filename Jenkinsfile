node('docker') {

    checkout scm

    docker.image('optibrium/buildcontainer:0.10.0').inside {

        stage('Build wheel') {
            script {
                sh 'python3 setup.py bdist_wheel'
            }
        }

        stage('Upload to PyPi') {
            if (env.TAG_NAME ==~ /v[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}/) {

                withCredentials(
                    [string(credentialsId: 'pypi-password', variable: 'PASSWORD')]
                ) {

                    sh 'twine upload --repository-url https://pypi.infra.optibrium.com -u twine -p ${PASSWORD} dist/*.whl'
                }
            }
        }
    }

    if (env.TAG_NAME ==~ /v[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}/) {

        stage('build Docker image') {
            app = docker.build("optibrium/secureclip")
        }

        stage('tag Docker image') {
            TAG = env.TAG_NAME.replace('v', '')
            app.tag("${TAG}")
        }

        stage('push Docker image') {
            app.push()
            app.push("${TAG}")
        }

        node('master') {
            stage('Update clip deployment in infra') {
                sh "kubectl set image deployment/clip clip=optibrium/secureclip:${TAG}"
            }
        }
    }
}
