FROM  debian:buster
MAINTAINER Helene Herin <hherin@student.42.fr>

RUN apt-get update && apt-get install -y vim unzip wget curl
RUN apt-get update && apt-get install -y nginx mariadb-server mariadb-client \ 
php7.3 php7.3-fpm php7.3-mysql php-curl php-gd php-intl php-mbstring php-soap \
 php-xml php-xmlrpc php-zip
RUN mkdir -p /run/php /var/www/42server/html
RUN chmod -R 755 /var/www/42server

ADD ./src/installation.sh /tmp/installation.sh
RUN sh /tmp/installation.sh && rm /tmp/installation.sh
RUN mkdir -p /etc/nginx/ssl/certs && mkdir -p /etc/nginx/ssl/private
ADD src/42server /etc/nginx/sites-available/42server
RUN ln -s /etc/nginx/sites-available/42server /etc/nginx/sites-enabled/42server
RUN rm /etc/nginx/sites-available/default && rm /etc/nginx/sites-enabled/default
ADD src/config.inc.php /var/www/42server/html/phpmyadmin/config.inc.php
RUN chmod 660 /var/www/42server/html/phpmyadmin/config.inc.php
RUN chown www-data.www-data -R /var/www/42server/html
ADD src/start.sh /tmp/start.sh

ENV PHP_PWD="bibilesamis"
ENV PHP_USER="hherin"
ENV WRD_USER="Hherin"
ENV WRD_PWD="bobolesamis"

EXPOSE 80 443

ENTRYPOINT ["bin/bash", "/tmp/start.sh"]
