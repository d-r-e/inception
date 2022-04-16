ARG DEBIAN_VERSION=buster
FROM debian:${DEBIAN_VERSION}
ARG CERTS
RUN apt-get update && apt-get install -y \
    nginx curl \
    && rm -rf /var/lib/apt/lists/*
COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /etc/ssl
COPY "${CERTS}"/inception.crt /etc/ssl/inception.crt
COPY "${CERTS}"/inception.key /etc/ssl/inception.key
CMD ["nginx", "-g", "daemon off;"]