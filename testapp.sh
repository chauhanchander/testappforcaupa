#!/bin/bash

export GO=`which go`
export DOCKER=`which docker`
export KUBECTL=`which kubectl`
export CURL=`which curl`

if [ "$#" -ne 1 ]; then
   echo "Usage: $0 ImagaeName" >&2
   exit 1
fi

# Run Unit Tests 

export TEST_RESULT=`"${GO}" test -v .`

# Build images
${DOCKER} build -t ${1} .

# Run application

${DOCKER} run -i -t --rm -p 8080:8080 ${1}
 
