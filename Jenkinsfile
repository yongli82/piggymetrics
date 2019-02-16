/**
 * 参考
 * https://www.kancloud.cn/huyipow/kubernetes/722822
 */
node('master') {
    stage('Clone') {
        echo "1. Clone Stage"
        git url: "https://github.com/yongli82/piggymetrics.git"
        script {
            build_tag = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
        }
    }
    stage('Maven Build') {
        // Run the maven build
        echo "2. Maven build"
        sh "mvn -DskipTests package"
    }
    stage('Docker Build') {
        echo "3. Build Docker Image Stage"
        sh "docker-compose -f docker-compose.yml -f docker-compose.dev.yml build"
    }

    stage('Push') {
        echo "4. Push Docker Image Stage"
        withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
            sh "docker login -u ${dockerHubUser} -p ${dockerHubPassword}"
            sh "docker push yangyongli/piggymetrics/jenkins-demo:${build_tag}"
        }
    }
    stage('Deploy') {
        echo "5. Deploy Stage"
        def userInput = input(
                id: 'userInput',
                message: 'Choose a deploy environment',
                parameters: [
                        [
                                $class : 'ChoiceParameterDefinition',
                                choices: "Dev\nQA\nProd",
                                name   : 'Env'
                        ]
                ]
        )
        echo "This is a deploy step to ${userInput}"
        sh "sed -i 's/<BUILD_TAG>/${build_tag}/' k8s.yaml"
        if (userInput == "Dev") {
            // deploy dev stuff
        } else if (userInput == "QA") {
            // deploy qa stuff
        } else {
            // deploy prod stuff
        }
        sh "kubectl apply -f k8s.yaml"
    }
}