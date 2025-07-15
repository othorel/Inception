ARG DEBIAN_VERSION=bullseye-slim
FROM debian:${DEBIAN_VERSION}

RUN apt-get update && apt-get install -y \
    vsftpd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY conf/vsftpd.conf /etc/vsftpd.conf
COPY conf/entrypoint.sh /init.sh

RUN chmod +x /init.sh
RUN mkdir -p /var/run/vsftpd/empty

ENTRYPOINT ["/init.sh"]
