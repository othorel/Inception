FROM debian:bullseye

# MAJ + installation de nginx
RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Suppression du site par défaut + ajout du nôtre
RUN rm -rf /var/www/html/*

COPY html/ /var/www/html/
COPY default.conf /etc/nginx/sites-available/default

# Expose le port HTTP
EXPOSE 81

CMD ["nginx", "-g", "daemon off;"]
