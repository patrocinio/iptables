CURL=/usr/local/opt/curl/bin/curl

function getPath {
  oc get route test-pump --no-headers=true | awk '{print $2}'
}

function pump {
  echo Calling test-pump
  $CURL $PATH/pump
}

PATH=$(getPath)
echo Path: $PATH

#reset
#define
#list
#increment
pump
