#!/bin/bash -x

HTTP_ENDPOINT=http://localhosts
DOCKER_ENDPOINT=url="${HTTP_ENDPOINT}/containers/json?filters=\{\"health\":\[\"unhealthy\"\]"

docker_curl() {
  curl --max-time "3" --no-buffer -s \
  --unix-socket ${DOCKER_SOCK} \
  "$@"
  echo "Result: $?"
}

while true; do
    sleep 3
    docker_curl ${DOCKER_ENDPOINT} 
done
