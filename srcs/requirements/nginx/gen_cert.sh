#!/bin/bash
openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
  -keyout conf/certs/inception.key -out conf/certs/inception.crt -extensions san -config \
  <(echo "[req]"; 
    echo distinguished_name=req; 
    echo "[san]"; 
    echo subjectAltName=DNS:localhost,DNS:darodrig.localhost,IP:127.0.0.1
    ) \
     -subj "/C=ES/ST=Spain/L=Madrid/O=Inception/CN=localhost"