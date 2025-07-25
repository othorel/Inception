#!/bin/sh

adduser --disabled-password --gecos "" --home /var/www/wordpress $FTP_USER
echo "$FTP_USER:$FTP_PASS" | chpasswd

mkdir -p /var/www/wordpress
chown -R "$FTP_USER:$FTP_USER" /var/www/wordpress

echo "local_root=/var/www/wordpress" >> /etc/vsftpd.conf
echo "$FTP_USER" > /etc/vsftpd.userlist

echo "FTP Started on :21"
/usr/sbin/vsftpd /etc/vsftpd.conf