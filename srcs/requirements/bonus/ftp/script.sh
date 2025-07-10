#!/bin/sh

ftp_user="wordpress"
ftp_pwd="wordpresspass"

# Création de l'utilisateur sans mot de passe expiré
adduser --disabled-password --gecos "" $ftp_user 

# Définition du mot de passe
echo "$ftp_user:$ftp_pwd" | chpasswd

# Création du dossier ftp dans son home
mkdir -p /home/$ftp_user/ftp

# Donner les droits à l'utilisateur ftp sur ce dossier
chown -R "$ftp_user:$ftp_user" /home/$ftp_user/ftp

# Ajouter la configuration vsftpd dynamique
echo "user_sub_token=$ftp_user" >> /etc/vsftpd.conf
echo "local_root=/home/$ftp_user/ftp" >> /etc/vsftpd.conf

# Ajouter l'utilisateur dans la liste des utilisateurs autorisés
echo "$ftp_user" | tee -a /etc/vsftpd.userlist

# Lancer le service vsftpd
exec "$@"
