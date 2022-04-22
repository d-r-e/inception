FROM debian:buster
RUN apt-get update && apt-get install -y curl jq

COPY conf/autoheal.sh /entrypoint.sh
RUN chmod 700 /entrypoint.sh
# HEALTHCHECK --interval=5s CMD pgrep -f autoheal
ENTRYPOINT [ "/entrypoint.sh" ]