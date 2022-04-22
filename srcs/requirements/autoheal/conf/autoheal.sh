#!/bin/bash

HTTP_ENDPOINT=http://localhost
DOCKER_ENDPOINT=url="${HTTP_ENDPOINT}/containers/json?filters=\{\"health\":\[\"unhealthy\"\]"

## Minimalist version from the fantastic Autoheal from Will Farrell

get_unhealthy_containers() {
  # curl -s -XGET --unix-socket /var/run/docker.sock "http://localhost/containers/json?filters=\{\"health\":\[\"unhealthy\"\]\}" | jq .
  curl -s -XGET --unix-socket /var/run/docker.sock "http://localhost/containers/json?filters=\{\"health\":\[\"unhealthy\"\]\}" 
}
echo Autoheal is watching...

# tail -f &>/dev/null
while true; do
    sleep $AUTOHEAL_INTERVAL
    get_unhealthy_containers | jq -r '.[].Names' | while read dead; do
      dead=$(echo $dead | sed 's/\///g' | sed 's/\"//g' | sed 's/\[//g' | sed 's/\]//g' | tr -d ' ')
      ## if dead length is greater than 1, then it's a container name
      if [ ${#dead} -gt 1 ]; then
        echo "Restarting container $dead"
        # docker restart $dead
        curl -s -X POST --unix-socket /var/run/docker.sock "http://localhost/containers/$dead/restart"
      fi
      # echo Trying to restart $dead
    done
done


#curl -XGET --unix-socket /var/run/docker.sock "http://localhost/containers/json?filters=\{\"health\":\[\"unhealthy\"\]${label_filter}\}"

