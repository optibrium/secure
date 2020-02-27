node('docker') {

    def PROJECT = 'optibrium/secureclip'
    def BUILDCONTAINER = 'optibrium/buildcontainer:0.21.1'

    checkout scm

    stage('Collect environment variables') {

        if (env.TAG_NAME ==~ /v[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}(\-.*)?/) {

            env.GIT_TAG = env.TAG_NAME.replaceFirst('v', '')
        }
    }

    docker.image(BUILDCONTAINER).inside {
    
        stage('Build wheel') {
            script {
                sh 'python3 setup.py bdist_wheel'
            }
        }
    
        if (env.GIT_TAG) {
    
            stage('Upload to PyPi') {
    
                withCredentials([string(credentialsId: 'pypi-password', variable: 'PYPI_PASSWORD')]) {

                    sh 'twine upload --repository-url https://pypi.infra.optibrium.com -u twine -p ${PYPI_PASSWORD} dist/*.whl'
                }
            }
        }
    }
    
    if (env.GIT_TAG) {
    
        stage('build Docker image') {
            app = docker.build(PROJECT)
        }
    
        stage('tag Docker image') {
            app.tag(env.GIT_TAG)
        }
    
        stage('push Docker image') {
            app.push()
            app.push(env.GIT_TAG)
        }
    
        node('master') {
            stage('Update clip deployment in infra') {
                sh "kubectl set image deployment/clip clip=PROJECT:${env.GIT_TAG}"
            }
        }
    }
}
