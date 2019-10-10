function createProject {
  echo Creating project...
  kubectl new-project iptables
}

function deployRedis {
  echo Deploying redis
  kubectl run redis --image=redis
}

function exposeRedis {
  kubectl expose dc redis --port=6379
}

function deployKeyCounter {
  echo Deploying key counter
  kubectl run key-counter --image=patrocinio/iptables-key-counter
}

function exposeKeyCounter {
  kubectl expose dc key-counter --port=8080
  kubectl expose svc key-counter
}

function deployDispatcher {
  echo Deploying counter
  kukectl create -f ../config/dispatcher.yaml
}

function exposeDispatcher {
  kubectl create -f ../config/dispatcher-svc.yaml
  kubectl expose svc dispatcher
}
function deployTestPump {
  echo Deploying test pump
  kubectl run test-pump --image=patrocinio/iptables-test-pump
}

function exposeTestPump {
  kubectl expose dc test-pump --port=8080
  kubectl expose svc test-pump
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
