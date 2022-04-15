FROM debian:buster

RUN apt-get update && apt-get install -y \
    nginx curl \
    && rm -rf /var/lib/apt/lists/*
COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /etc/ssl
COPY ./conf/certs/inception.crt /etc/ssl/inception.crt
COPY ./conf/certs/inception.key /etc/ssl/inception.key
CMD ["nginx", "-g", "daemon off;"]