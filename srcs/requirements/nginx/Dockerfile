FROM debian:oldstable

RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir -p /etc/ssl/private /etc/ssl/certs /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=FR/ST=Paris/L=Paris/O=42/CN=mpeyre-s.42.fr" && \
    cp /etc/ssl/private/nginx-selfsigned.key /etc/nginx/ssl/nginx-selfsigned.key && \
    cp /etc/ssl/certs/nginx-selfsigned.crt /etc/nginx/ssl/nginx-selfsigned.crt

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]