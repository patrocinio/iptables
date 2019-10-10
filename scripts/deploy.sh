function createProject {
  echo Creating project...
  oc new-project iptables
}

function deployRedis {
  echo Deploying redis
  oc run redis --image=redis
}

function exposeRedis {
  oc expose dc redis --port=6379
}

function deployKeyCounter {
  echo Deploying key counter
  oc run key-counter --image=patrocinio/iptables-key-counter
}

function exposeKeyCounter {
  oc expose dc key-counter --port=8080
  oc expose svc key-counter
}

function deployDispatcher {
  echo Deploying counter
  oc create -f ../config/dispatcher.yaml
}

function exposeDispatcher {
  oc create -f ../config/dispatcher-svc.yaml
  oc expose svc dispatcher
}
function deployTestPump {
  echo Deploying test pump
  oc run test-pump --image=patrocinio/iptables-test-pump
}

function exposeTestPump {
  oc expose dc test-pump --port=8080
  oc expose svc test-pump
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
