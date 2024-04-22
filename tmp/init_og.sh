#!/bin/bash
set -e

# # Exit shell script when commands fail
# set -e

# chown -R mysql:mysql /var/lib/mysql
pkill mysqld || true

rm -rf /var/lib/mysql/*

# Check if the system table is already installed
if [ ! -d /var/lib/mysql/${MYSQL_DATABASE} ]; then
    echo "Database not installed, initializing..."
    # mariadb-install-db --user=mysql
    mariadb-install-db
	echo "mariaDB installed" 

    # # Start MariaDB server in background
    # mariadbd &
	# echo "mairadb background"
    
    # # Wait until MariaDB server is up
    # mariadb-admin ping --wait=1 --connect-timeout=30
	# echo "mairadb ping"

	service mariadb start

	echo "MYSQL_ROOT_PASWORD: $MYSQL_ROOT_PASSWORD"
    
    # Set root user's password and configure database
    # mysql -u root -h localhost -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
	# echo "alter user root"
    # mysql -u root -h localhost -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
	# echo "create database"
    # mysql -u root -h localhost -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';"
	# echo "create user"
    # mysql -u root -h localhost -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
	# echo "grant all privileges"
    # mysql -u root -h localhost -e "FLUSH PRIVILEGES;"
	# echo "flush privileges"


    # mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
	# echo "alter user root"
    # mysql -u root -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
	# echo "create database"
    # mysql -u root -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';"
	# echo "create user"
    # mysql -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
	# echo "grant all privileges"
    # mysql -u root -e "FLUSH PRIVILEGES;"
	# echo "flush privileges"
	

	# # echo "Configuring root user permissions..."
    # # mysql -u root --password='' -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;"
    # # mysql -u root --password="$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD' WITH GRANT OPTION;"
    # # mysql -u root --password="$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

    # # echo "Creating database and user..."
    # # mysql -u root --password="$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
    # # mysql -u root --password="$MYSQL_ROOT_PASSWORD" -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';"
    # # mysql -u root --password="$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
    # # mysql -u root --password="$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"
    
    # # Stop the MariaDB server
    # # mariadb-admin shutdown
	# mariadb-admin -u$MYSQL_ROOT -p$MYSQL_ROOT_PASSWORD shutdown
    
    # echo "Database setup complete."

	# 환경 변수에서 비밀번호를 가져와서 사용
	 # Set root user's password and configure database
    # mysql -u root --password="$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;"

	mysql -u root --password="$MYSQL_ROOT_PASSWORD" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
    echo "alter user root"
    mysql -u root --password="$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
    echo "create database"
    mysql -u root --password="$MYSQL_ROOT_PASSWORD" -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';"
    echo "create user"
    mysql -u root --password="$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
    echo "grant all privileges"
    mysql -u root --password="$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"
    echo "flush privileges"

    # mariadb-admin -u root --password="$MYSQL_ROOT_PASSWORD" shutdown
	service mariadb stop
    echo "Database setup complete."
else
    echo "Database already installed."
fi

# Start MariaDB server in foreground
# exec mysqld_safe
# exec "$@"

mysqld --user=root
