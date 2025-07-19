#!/bin/bash

mysqld_safe &
sleep 5

mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MDB_NAME}\`;"

mariadb -e "CREATE USER IF NOT EXISTS \`${MDB_USER}\`@'%' IDENTIFIED BY '${MDB_USER_PASS}';"

mariadb -e "GRANT ALL PRIVILEGES ON \`${MDB_NAME}\`.* TO \`${MDB_USER}\`@'%';"

mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MDB_ROOT_PASS}';"

mariadb -e "FLUSH PRIVILEGES;"

mariadb-admin -u root -p"${MDB_ROOT_PASS}" shutdown

killall mysqld_safe
wait

exec mysqld_safe