#!/bin/bash

mysqld_safe &
sleep 5

# Créer la base de données
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MDB_NAME}\`;"

# Créer l'utilisateur s'il n'existe pas
mariadb -e "CREATE USER IF NOT EXISTS \`${MDB_USER}\`@'%' IDENTIFIED BY '${MDB_USER_PASS}';"

# Donner les droits à l'utilisateur sur la base
mariadb -e "GRANT ALL PRIVILEGES ON \`${MDB_NAME}\`.* TO \`${MDB_USER}\`@'%';"

# Modifier le mot de passe root
mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MDB_ROOT_PASS}';"

# Appliquer les modifications
mariadb -e "FLUSH PRIVILEGES;"

# Éteindre proprement MariaDB
mariadb-admin -u root -p"${MDB_ROOT_PASS}" shutdown

# Nettoyage
killall mysqld_safe
wait

# Démarrer définitivement MariaDB
exec mysqld_safe