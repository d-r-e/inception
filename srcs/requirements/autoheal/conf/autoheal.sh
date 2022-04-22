#!/bin/bash

HTTP_ENDPOINT=http://localhost
DOCKER_ENDPOINT=url="${HTTP_ENDPOINT}/containers/json?filters=\{\"health\":\[\"unhealthy\"\]"

## Minimalist version from the fantastic Autoheal from Will Farrell

get_unhealthy_containers() {
  curl -XGET -s --unix-socket /var/run/docker.sock "http://localhost/containers/json?filters=\{\"health\":\[\"unhealthy\"\]${label_filter}\}" | jq .
}
# tail -f &>/dev/null
while true; do
    sleep 3
    json=$(get_unhealthy_containers)
    echo $json
done

#curl -XGET --unix-socket /var/run/docker.sock "http://localhost/containers/json?filters=\{\"health\":\[\"unhealthy\"\]${label_filter}\}"