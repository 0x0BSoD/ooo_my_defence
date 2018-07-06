FROM debian:9

RUN apt update && apt -y upgrade && DEBIAN_FRONTEND=noninteractive apt -y install \
    apt-utils apache2 php php-mysql libapache2-mod-php

RUN a2enmod rewrite

RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.0/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/7.0/apache2/php.ini

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

EXPOSE 80

COPY www /var/www/site

ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf


CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
