#!/bin/bash
set -e

# Exit shell script when commands fail
set -e

chown -R mysql:mysql /var/lib/mysql

# Check if the system table is already installed
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Database not installed, initializing..."
    mariadb-install-db --user=mysql 

    # Start MariaDB server in background
    mariadbd &
    
    # Wait until MariaDB server is up
    mariadb-admin ping --wait=1 --connect-timeout=30
    
    # # Set root user's password and configure database
    # mysql -u root -h localhost -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
    # mysql -u root -h localhost -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
    # mysql -u root -h localhost -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';"
    # mysql -u root -h localhost -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
    # mysql -u root -h localhost -e "FLUSH PRIVILEGES;"

	echo "Configuring root user permissions..."
    mysql -u root --password='' -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;"
    mysql -u root --password="$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD' WITH GRANT OPTION;"
    mysql -u root --password="$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

    echo "Creating database and user..."
    mysql -u root --password="$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
    mysql -u root --password="$MYSQL_ROOT_PASSWORD" -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';"
    mysql -u root --password="$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
    mysql -u root --password="$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"
    
    # Stop the MariaDB server
    mariadb-admin shutdown
    
    echo "Database setup complete."
else
    echo "Database already installed."
fi

# Start MariaDB server in foreground
exec mysqld_safe
