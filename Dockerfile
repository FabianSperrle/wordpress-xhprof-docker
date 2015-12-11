FROM wordpress:latest

RUN apt-get update && apt-get install -y php5-dev libmcrypt-dev git

RUN echo "Install XHprof"
RUN pecl install xhprof-beta
RUN pecl install mongo

RUN docker-php-ext-install mcrypt zip

RUN echo "extension=xhprof.so" > /usr/local/etc/php/php.ini
RUN echo "extension=mongo.so" >> /usr/local/etc/php/php.ini
RUN echo "auto_prepend_file=\"/var/www/html/xhgui-2.0/external/header.php\"" >> /usr/local/etc/php/php.ini

ADD docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
