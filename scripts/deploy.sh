# Openshift
#DEPLOY=dc

# Kubernetes
DEPLOY=deployment

function createProject {
  echo Creating project...
  kubectl new-project iptables
}

function deployRedis {
  echo Deploying redis
  kubectl run redis --image=redis
}

function exposeRedis {
  kubectl expose $DEPLOY redis --port=6379
}

function deployKeyCounter {
  echo Deploying key counter
  kubectl run key-counter --image=patrocinio/iptables-key-counter
}

# OpenShift
#function exposeApp {
#   kubectl expose svc key-counter
#}

function exposeApp {
  TYPE=$1
  DEPLOY=$2
  echo Creating NodePort for $DEPLOY
  kubectl expose $TYPE $DEPLOY --type=NodePort --name=$DEPLOY-np \
    --port=8080
}

function exposeKeyCounter {
  kubectl expose $DEPLOY key-counter --port=8080
  exposeApp deploy key-counter
}

function deployDispatcher {
  echo Deploying counter
  kubectl create -f ../config/dispatcher.yaml
}

function exposeDispatcher {
  kubectl create -f ../config/dispatcher-svc.yaml
  exposeApp sts dispatcher
}
function deployTestPump {
  echo Deploying test pump
  kubectl run test-pump --image=patrocinio/iptables-test-pump
}

function exposeTestPump {
  kubectl expose $DEPLOY test-pump --port=8080
  exposeApp deploy test-pump
}

createProject
deployRedis
exposeRedis
deployKeyCounter
exposeKeyCounter
deployDispatcher
exposeDispatcher
deployTestPump
exposeTestPump
