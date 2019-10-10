CURL=/usr/local/opt/curl/bin/curl
KEY=my-key

function getPath {
  oc get route key-counter --no-headers=true | awk '{print $2}'
}

function list {
  echo Listing
  $CURL $PATH/list
}

PATH=$(getPath)
echo Path: $PATH

list
