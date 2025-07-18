ARG DEBIAN_VERSION=bullseye-slim
FROM debian:${DEBIAN_VERSION}

RUN 		apt -y update && apt -y upgrade
RUN 		apt -y install wget 

WORKDIR		/usr/local/bin

RUN 		wget https://github.com/google/cadvisor/releases/download/v0.39.0/cadvisor
RUN 		chmod +x cadvisor

ENTRYPOINT	[ "cadvisor" ]