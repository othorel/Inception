#!/bin/sh

# Créer l'utilisateur avec son dossier de connexion dans /var/www/wordpress
adduser --disabled-password --gecos "" --home /var/www/wordpress $FTP_USER
echo "$FTP_USER:$FTP_PASS" | chpasswd

# Créer le dossier et donner les droits
mkdir -p /var/www/wordpress
chown -R "$FTP_USER:$FTP_USER" /var/www/wordpress

# Modifier la configuration vsftpd
echo "local_root=/var/www/wordpress" >> /etc/vsftpd.conf
echo "$FTP_USER" > /etc/vsftpd.userlist

echo "FTP Started on :21"
/usr/sbin/vsftpd /etc/vsftpd.conf