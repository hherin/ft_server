#! bin/bash

service nginx start
service mysql start
service php7.3-fpm restart
mariadb < /var/www/42server/html/phpmyadmin/sql/create_tables.sql
echo 'databases creation...'
mariadb -u root -e "GRANT SELECT, INSERT, UPDATE, DELETE ON phpmyadmin.* TO 'pma'@'localhost' IDENTIFIED BY 'password';"
mariadb -u root -e "GRANT ALL PRIVILEGES ON *.* TO '$PHP_USER'@'localhost' IDENTIFIED BY '$PHP_PWD' WITH GRANT OPTION;"
mariadb -u root -e "FLUSH PRIVILEGES;"
mariadb -u root -e "CREATE DATABASE wp1;"
mariadb -u root -e "USE wp1;"
mariadb -u root -e "GRANT ALL PRIVILEGES ON wp1.* to '$WRD_USER'@'localhost' IDENTIFIED BY '$WRD_PWD';"
mariadb -u root -e "FLUSH PRIVILEGES;"
sh
