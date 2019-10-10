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

#createProject
#deployRedis
exposeRedis
#deployKeyCounter
#exposeKeyCounter
