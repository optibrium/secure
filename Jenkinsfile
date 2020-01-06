node('docker') {

    checkout scm

    docker.image('optibrium/buildcontainer:0.6.0').inside {

        stage('Install build dependencies') {
            script {
                sh 'pip3 install --no-cache-dir --user -r requirements.txt'
            }
        }

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

    stage('build Docker image, tag and push') {
        if (env.TAG_NAME ==~ /v[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}/) {
            app = docker.build("optibrium/secureclip")
            TAG = env.TAG_NAME.replace('v', '')
            app.tag("${TAG}")
            app.push("${TAG}")
        }
    }
}
