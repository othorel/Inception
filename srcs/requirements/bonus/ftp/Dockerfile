FROM debian:bullseye

RUN apt-get update && apt-get install -y vsftpd && \
    rm -rf /var/lib/apt/lists/*

# Créer un utilisateur ftpuser avec home /home/ftpuser/wordpress
RUN useradd -m -d /home/ftpuser/wordpress ftpuser && echo "ftpuser:ftppass" | chpasswd

# Créer le dossier wordpress dans son home et donner les droits
RUN mkdir -p /home/ftpuser/wordpress && chown -R ftpuser:ftpuser /home/ftpuser/wordpress

# Copier le fichier de configuration vsftpd (à créer dans le même dossier)
COPY vsftpd.conf /etc/vsftpd.conf

VOLUME ["/home/ftpuser/wordpress"]

EXPOSE 20 21 21100-21110

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]
