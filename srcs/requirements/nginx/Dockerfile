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

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "curl", "--fail", "--silent", "--show-error", "--insecure", "-I", "https://nginx/" ]
CMD ["nginx", "-g", "daemon off;"]
