CURL=/usr/local/opt/curl/bin/curl
KEY=my-key

function getPath {
  oc get route key-counter --no-headers=true | awk '{print $2}'
}

function reset {
  echo Resetting Keys
  $CURL $PATH/reset
}

function list {
  echo Listing
  $CURL $PATH/list
}

function define {
  echo Defining one key
  $CURL $PATH/define/$KEY
}

function increment {
  echo Incremeting key
  $CURL $PATH/inc/$KEY
}

PATH=$(getPath)
echo Path: $PATH

#reset
#define
#list
#increment
list
