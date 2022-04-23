FROM debian:buster

RUN apt-get update && apt-get install -y\
    nginx curl
COPY src/astro/dist /var/www/html
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "curl", "--fail", "--silent", "--show-error", "--insecure", "-I", "http:/localhost:80/" ]
CMD ["nginx", "-g", "daemon off;"]