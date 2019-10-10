CURL=/usr/local/opt/curl/bin/curl

function getPath {
  oc get route dispatcher --no-headers=true | awk '{print $2}'
}

function pump {
  $CURL $PATH/pump
}


PATH=$(getPath)
echo Path: $PATH

pump
