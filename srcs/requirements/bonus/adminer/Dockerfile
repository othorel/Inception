ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye-slim}

RUN apt-get update && apt-get install -y \
    curl less \
	php7.4 \
	php7.4-fpm \
	php7.4-mysql &&\
    apt clean && \
    rm -rf /var/lib/apt/lists/*
    
    RUN mkdir -p /run/php
    
    COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
    

RUN \
    curl -L -O https://github.com/vrana/adminer/releases/download/v5.3.0/adminer-5.3.0.php && \
    mkdir -p /var/www/adminer && \
    mv ./adminer-5.3.0.php /var/www/adminer/index.php && \
    chmod 755 /var/www/adminer/index.php

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["php-fpm7.4", "--nodaemonize"]