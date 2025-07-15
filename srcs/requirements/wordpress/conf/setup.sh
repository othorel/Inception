#!/bin/bash

cd /var/www/wordpress

echo "Testing database connection..."
echo "    - User: $MYSQL_USER"
echo "    - Database: $MYSQL_DATABASE"
echo "    - Host: $MYSQL_HOST"

until mysqladmin -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" ping &>/dev/null; do
    echo "Waiting for MariaDB... (Trying to connect as $MYSQL_USER)"
    sleep 5
done

echo "Database connection successful!"

if [ ! -f wp-config.php ]; then
    echo "Creating wp-config.php..."

    wp config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="$MYSQL_HOST" \
        --path=/var/www/wordpress \
        --allow-root

    wp core install \
        --url="$DOMAIN_NAME" \
        --title="Inception" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root

    wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --role=author \
        --user_pass="$WP_USER_PASSWORD" \
        --allow-root

    echo "Installing and configuring Redis Object Cache plugin..."

    wp plugin install redis-cache --activate --allow-root
    wp config set WP_REDIS_HOST "redis" --allow-root
    wp config set WP_REDIS_PORT 6379 --raw --allow-root
    wp config set WP_CACHE_KEY_SALT "$DOMAIN_NAME" --allow-root
    wp config set WP_REDIS_CLIENT "phpredis" --allow-root
    wp config set WP_CACHE true --raw --allow-root

    if nc -z redis 6379; then
        wp redis enable --allow-root
    else
        echo "Redis server not reachable at redis:6379, skipping cache enable."
    fi

    echo "WordPress successfully installed."
else
    echo "WordPress is already configured."
fi

echo "Launching PHP-FPM..."
exec /usr/sbin/php-fpm7.4 -F
