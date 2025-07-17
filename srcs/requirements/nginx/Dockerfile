ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye-slim}
# RUN adduser --disabled-password --gecos "" app
# USER app

RUN		apt update -y && \
		apt install -y nginx openssl curl gettext-base && \
		apt clean && \
		rm -rf /var/lib/apt/lists/*

ARG LOGIN
ARG DOMAIN_NAME

RUN mkdir -p /etc/nginx/ssl

ENV SSL_CERT=/etc/nginx/ssl/inception.crt
ENV SSL_KEY=/etc/nginx/ssl/inception.key

RUN openssl req -x509 -nodes -days 365 \
	-out ${SSL_CERT} \ 
	-keyout ${SSL_KEY} \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=${DOMAIN_NAME}/UID=${LOGIN}"

COPY conf/nginx.conf.template /etc/nginx/nginx.conf.template
RUN envsubst '${SSL_CERT} ${SSL_KEY} ${DOMAIN_NAME}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]