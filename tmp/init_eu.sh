#!/bin/bash 

if [ ! -d /var/lib/mysql/${DATABASE_NAME} ]; then
    
    mariadb-install-db
	echo "	@ @ HERE _ 1 @ @ mairaDB is installed. "

    service mariadb start
	echo "	@ @ HERE _ 2 @ @ mairaDB is started. "

    mysql -u root -e "CREATE DATABASE $DATABASE_NAME;"
	#if not 들어감
	echo "	@ @ HERE _ 3 @ @ mairaDB is created. "
    mysql -u root -e "CREATE user $DATABASE_USER@'%' identified by '$DATABASE_PASSWORD';"
	echo "	@ @ HERE _ 4 @ @ mairaDB user is created. "
    mysql -u root -e "GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO $DATABASE_USER@'%';"
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