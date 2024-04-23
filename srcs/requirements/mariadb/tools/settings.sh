#!/bin/bash 

if [ ! -d /var/lib/mysql/${MYSQL_DATABASE} ]; then
    
    mariadb-install-db
	echo "	@ @ HERE _ 1 @ @ mairaDB is installed. "

    service mariadb start
	echo "	@ @ HERE _ 2 @ @ mairaDB is started. "

    mysql -u root -e "CREATE DATABASE $MYSQL_DATABASE;"
	#if not 들어감
	echo "	@ @ HERE _ 3 @ @ mairaDB is created. "
    mysql -u root -e "CREATE user $MYSQL_USER@'%' identified by '$MYSQL_PASSWORD';"
	echo "	@ @ HERE _ 4 @ @ mairaDB user is created. "
    mysql -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO $MYSQL_USER@'%';"
	echo "	@ @ HERE _ 5 @ @ mairaDB user is granted. "
    mysql -u root -e "FLUSH PRIVILEGES;"
	echo "	@ @ HERE _ 6 @ @ mairaDB is flushed. "
    
    service mariadb stop
	echo "	@ @ HERE _ 7 @ @ mairaDB is stopped. "

else
    echo "-- MariaDB already setted--"
fi

mysqld --user=root
#mariadbd 포그라운드