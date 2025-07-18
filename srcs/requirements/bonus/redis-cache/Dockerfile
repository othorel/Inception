FROM debian:oldstable

RUN apt-get update && \
    apt-get install -y redis-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Par défaut, Redis est lancé en mode protégé (protégé = refuse les connexions non locales)
# On désactive ce mode pour autoriser WordPress à se connecter depuis le réseau Docker
CMD ["redis-server", "--protected-mode", "no"]
