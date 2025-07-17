ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION:-bullseye-slim}

# Installer les outils nécessaires pour compiler (make, gcc, etc)
RUN apt-get update && apt-get install -y build-essential && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copier le dossier webserv (Makefile + sources)
COPY ./webserv /app/webserv
COPY ./conf /app/webserv/conf

WORKDIR /app/webserv

# Compiler avec make
RUN make

EXPOSE 8000
# Lancer le binaire avec le fichier de config en argument
CMD ["./webserv", "conf/default.conf"]