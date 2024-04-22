#!/bin/bash 

if [ ! -d /var/lib/mysql/${MYSQL_DATABASE} ]; then
    
    mariadb-install-db

    service mariadb start

    mysql -u root -e "CREATE DATABASE $MYSQL_DATABASE;"
    mysql -u root -e "CREATE user $MYSQL_USER@'%' identified by '$MYSQL_PASSWORD';"
    mysql -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO $MYSQL_USER@'%';"
    mysql -u root -e "FLUSH PRIVILEGES;"
    
    service mariadb stop

else
    echo "-- MariaDB already setted--"
fi

mysqld --user=root