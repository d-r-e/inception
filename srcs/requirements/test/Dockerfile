FROM debian:buster

RUN apt-get update && apt-get install -y \
    nginx curl \
    && rm -rf /var/lib/apt/lists/*
COPY html/index.html /var/www/html/index.html
COPY html/index.html /usr/share/nginx/html/index.html
CMD ["nginx", "-g", "daemon off;"]