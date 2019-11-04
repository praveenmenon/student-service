node{

  //Define all variables
  def project = 'student-service'
  def appName = 'swe-645'
  def serviceName = "${appName}-backend"  
  def imageVersion = "${env.BUILD_NUMBER}"
  def namespace = 'development'
  def imageTag = "${appName}:${imageVersion}"
  def dockerUser = 'praveenmenon'
  def loadBalancer = 'java-controller'
  def dockerId = 'praveenmenon'
  def dockerPass = 'Rainbow9'
  
  //Checkout Code from Git
  checkout scm

  stage('Login to docker'){
    sh("docker login -u ${dockerId} -p ${dockerPass} docker.io")
  }
  //Stage 1 : Build the docker image.
  stage('Build image') {
    sh("docker build -t ${imageTag} .")
  }

  //Stage 2 : Tag the docker image.
  stage('Tag image') {
    sh("docker tag ${imageTag} ${dockerUser}/${imageTag}")
  }
  
  //Stage 3 : Push the image to docker registry
  stage('Push image to registry') {
    sh("docker push ${dockerUser}/${imageTag}")
  }

  
  //Stage 4 : Deploy Application
  stage('Deploy Application') {
    switch (namespace) {
        //Roll out to Dev Environment
        case "development":
          //Create or update resources
          // sh("kubectl apply -f aws-eks-cluster.yaml")
          sh("cd ${HOME}/bin && echo kubectl apply -f mydeployment.yaml")
          //Grab the external Ip address of the service
          sh("cd ${HOME}/bin && echo http://`kubectl get service/${loadBalancer} --output=json | jq -r '.status.loadBalancer.ingress[0].hostname'`")
        break

        default:
        sh("kubectl apply -f aws-eks-cluster.yaml")
        sh("kubectl apply -f mydeployment.yaml")
        sh("echo http://`kubectl --namespace=${namespace} get service/${loadBalancer} --output=json | jq -r '.status.loadBalancer.ingress[0].hostname'` > ${feSvcName}")
        break
      }
    }
  }
