#CURL=/usr/local/opt/curl/bin/curl
CURL=curl
NODE=kube.patrocinio.org

function getPath {
  oc get route dispatcher --no-headers=true | awk '{print $2}'
}

function getPort {
  	port=$(kubectl get -o jsonpath="{.spec.ports[0].nodePort}" services $1)
	echo $port
}

function sendRequest {
  $CURL $NODE:$TARGET/$1
}



function pump {
  sendRequest pump
}

TARGET=$(getPort dispatcher-np)


# OpenShift
#PATH=$(getPath)
#echo Path: $PATH

pump
