#CURL=/usr/local/opt/curl/bin/curl
CURL=curl
NODE=kube.patrocinio.org

function getPath {
  oc get route test-pump --no-headers=true | awk '{print $2}'
}

function getPort {
  	port=$(kubectl get -o jsonpath="{.spec.ports[0].nodePort}" services $1)
	echo $port
}

function sendRequest {
  $CURL $NODE:$TARGET/$1
}



function pump {
  echo Calling test-pump
  sendRequest pump
}

# OpenShift
#PATH=$(getPath)
#echo Path: $PATH

TARGET=$(getPort test-pump-np)


#reset
#define
#list
#increment
pump
