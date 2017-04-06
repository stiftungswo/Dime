FROM php:7.0-apache
COPY . /dime
COPY env/conf/dime.docker.conf /etc/apache2/conf-enabled/dime.docker.conf