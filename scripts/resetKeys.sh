#CURL=/usr/local/opt/curl/bin/curl
CURL=curl

function getPath {
  oc get route key-counter --no-headers=true | awk '{print $2}'
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

# OpenShift
#PATH=$(getPath)
#echo Path: $PATH

TARGET=$(getPort key-counter-np)

reset
