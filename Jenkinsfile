node('docker') {

    checkout scm

    stage('Collect environment variables') {

        def PROJECT = 'optibrium/secureclip'
        def BUILDCONTAINER = 'optibrium/buildcontainer:0.21.1'

        if (env.TAG_NAME ==~ /v[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}(\-.*)?/) {

            def GIT_TAG = env.TAG_NAME.replaceFirst('v', '')

            withCredentials([
                string(credentialsId: 'pypi-password', variable: 'PYPI_PASSWORD'),
            ]) {
                def PYPI_PASSWORD = "${PYPI_PASSWORD}"
            }
        }

    }

    docker.image(env.BUILDCONTAINER).inside {
    
        stage('Build wheel') {
            script {
                sh 'python3 setup.py bdist_wheel'
            }
        }
    
        if (GIT_TAG) {
    
            stage('Upload to PyPi') {
    
                sh 'twine upload --repository-url https://pypi.infra.optibrium.com -u twine -p ${PYPI_PASSWORD} dist/*.whl'
            }
        }
    }
    
    if (GIT_TAG) {
    
        stage('build Docker image') {
            app = docker.build("optibrium/secureclip")
        }
    
        stage('tag Docker image') {
            app.tag(GIT_TAG)
        }
    
        stage('push Docker image') {
            app.push()
            app.push(GIT_TAG)
        }
    
        node('master') {
            stage('Update clip deployment in infra') {
                sh "kubectl set image deployment/clip clip=optibrium/secureclip:${GIT_TAG}"
            }
        }
    }
}
