FROM debian:buster

RUN apt-get update && apt-get install -y\
    nginx curl htop
# RUN sed -i 's/80/4242/g' /etc/nginx/nginx.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY --chown=root:root src/astro/dist /var/www/html
RUN chmod -R 755 /var/www/html
RUN nginx -t
WORKDIR /var/www/html
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "curl", "--fail", "--silent", "--show-error", "--insecure", "-I", "https:/nginx/astro/" ]
CMD ["nginx", "-g", "daemon off;"]