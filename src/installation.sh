#! bin/bash
latest=$(curl https://www.phpmyadmin.net/ | grep href | grep files | head -n 1 | sed 's/.*href=//g; s/"//g' |  awk '{ print $1 }');
wget $latest;
unzip phpMyAdmin*;
rm -rf phpMyAdmin*.zip;
mv phpMyAdmin* /var/www/42server/html/phpmyadmin;
chown -R www-data:www-data /var/www/42server/html/phpmyadmin;
mkdir -p /var/lib/phpmyadmin/tmp
wget http://wordpress.org/latest.zip
unzip latest.zip && rm -rf latest.zip
mv wordpress /var/www/42server/html
