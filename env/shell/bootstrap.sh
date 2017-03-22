#!/bin/sh

# print commands (-x)
set -x

# install useful helper packages
yum -y install vim vim-enhanced curl unzip wget git openssh-server

# install apache/mysql server
yum -y install httpd mariadb mariadb-server

# install php 7.1
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum -y install php71w php71w-common php71w-pear php71w-mbstring php71w-intl php71w-xml php71w-pecl-apcu php71w-process php71w-gd php71w-mcrypt php71w-phpdbg php71w-pdo php71w-mysql

# disable firewall for development
systemctl disable firewalld
systemctl stop firewalld

# disable SELinux for development
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/sysconfig/selinux
sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config

# increase limit of max open files, php coverage reports reached the default limit of 1028
ulimit -n 16384

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

# install xdebug
yum install php71w-devel php71w-pear php71w-pecl-xdebug
yum install gcc gcc-c++ autoconf automake
pecl install Xdebug
service httpd restart

# configure autostart on boot
sudo systemctl enable httpd.service
sudo systemctl enable mariadb.service

# install composer
if [ -f /usr/local/bin/composer.phar ]; then
    php /usr/local/bin/composer.phar selfupdate
else
    curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/
fi

# Install DIME (we need to run this as vagrant user)
/bin/su - vagrant -c "/vagrant/env/shell/install_dime.sh"

