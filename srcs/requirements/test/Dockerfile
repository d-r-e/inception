FROM debian:buster

RUN apt-get update && apt-get install -y \
    nmap curl \
    && rm -rf /var/lib/apt/lists/*
CMD [ "/bin/bash" ]