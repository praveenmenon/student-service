node{

  //Define all variables
  def project = 'student-service'
  def appName = 'swe-645'
  def serviceName = "${appName}-backend"  
  def imageVersion = '9.0'
  def namespace = 'development'
  def imageTag = "${appName}:${imageVersion}"
  def dockerUser = 'praveenmenon'
  def loadBalancer = 'java-controller'
  
  //Checkout Code from Git
  checkout scm
  
  //Stage 1 : Build the docker image.
  stage('Build image') {
    sh("sudo chown root:jenkins docker build -t ${imageTag} .")
  }
  
  //Stage 2 : Push the image to docker registry
  stage('Push image to registry') {
    sh("sudo chown root:jenkins docker push ${dockerUser}/${imageTag}")
  }
  
  //Stage 3 : Deploy Application
  stage('Deploy Application') {
    switch (namespace) {
        //Roll out to Dev Environment
        case "development":
        //Create or update resources
        sh("kubectl apply -f aws-eks-cluster.yaml")
        sh("kubectl apply -f mydeployment.yaml")
        //Grab the external Ip address of the service
        sh("echo http://`kubectl get service/${loadBalancer} --output=json | jq -r '.status.loadBalancer.ingress[0].hostname'` > ${feSvcName}")
        break

        default:
        sh("kubectl apply -f aws-eks-cluster.yaml")
        sh("kubectl apply -f mydeployment.yaml")
        sh("echo http://`kubectl --namespace=${namespace} get service/${loadBalancer} --output=json | jq -r '.status.loadBalancer.ingress[0].hostname'` > ${feSvcName}")
        break
      }
    }
  }
