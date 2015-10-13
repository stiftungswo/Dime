#!/bin/sh

# print commands (-x)
set -x

# install useful helper packages
yum -y install vim vim-enhanced curl unzip wget git openssh-server

# install apache/mysql server
yum -y install httpd mariadb mariadb-server

# install php
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum -y install php56w php56w-pear php56w-mbstring php56w-intl php56w-xml php56w-pecl-xdebug php56w-pecl-apcu php56w-process php56w-gd php56w-mcrypt php-phpunit-PHPUnit php56w-phpdbg php56w-pdo php56w-mysql

# disable firewall for development
systemctl disable firewalld
systemctl stop firewalld

# disable SELinux for development
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/sysconfig/selinux

# TODO: sshd config

# configure mysql/maria
service mariadb start
mysql -u root -e "CREATE DATABASE IF NOT EXISTS dime;"
mysql -u root -e "GRANT all privileges on dime.* to dime@'localhost' IDENTIFIED BY 'dime';"
mysql -u root -e "FLUSH PRIVILEGES;"
service mariadb restart

# configure httpd
/bin/cp /vagrant/env/config/dime.conf /etc/httpd/conf.d/dime.conf
/bin/cp /vagrant/env/config/dime.ini /etc/php.d/dime.ini
service httpd start


# install composer
if [ -f /usr/local/bin/composer.phar ]; then
    php /usr/local/bin/composer.phar selfupdate
else
    curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/
fi

# Install DIME (we need to run this as vagrant user)
/bin/su - vagrant -c "/vagrant/env/shell/install_dime.sh"

