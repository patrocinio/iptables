CURL=/usr/local/opt/curl/bin/curl
KEY=my-key
NODE=kube.patrocinio.org

function getPath {
  kubectl get route key-counter --no-headers=true | awk '{print $2}'
}

function getPort {
  	port=$(kubectl get -o jsonpath="{.spec.ports[0].nodePort}" services $1)
	echo $port
}

function sendRequest {
  $CURL $NODE:$TARGET/$1
}


function reset {
  echo Resetting Keys
  sendRequest reset
}

function list {
  echo Listing
  sendRequest list
}

function define {
  echo Defining one key
  sendRequest define/$KEY
}

function increment {
  echo Incremeting key
  sendRequest inc/$KEY
}

# OpenShift
# PATH=$(getPath)
# echo Path: $PATH

TARGET=$(getPort key-counter)

#reset
#define
#list
#increment
list
