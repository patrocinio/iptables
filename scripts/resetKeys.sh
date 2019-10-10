CURL=/usr/local/opt/curl/bin/curl
KEY=my-key

function getPath {
  oc get route key-counter --no-headers=true | awk '{print $2}'
}

function reset {
  echo Resetting Keys
  $CURL $PATH/reset
}


PATH=$(getPath)
echo Path: $PATH

reset
