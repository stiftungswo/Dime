#!/usr/bin/env bash

# setup
composer install

# db: permissions
mysql --host=mysql -u root -e "CREATE DATABASE IF NOT EXISTS dime;"
mysql --host=mysql -u root -e "GRANT all privileges on dime.* to dime@'%' IDENTIFIED BY 'dime';"
mysql --host=mysql -u root -e "FLUSH PRIVILEGES;"
mysql --host=mysql -u root -e "DROP DATABASE IF EXISTS dime; CREATE DATABASE dime;"

# db: schema & migrations
php app/console doctrine:schema:create
mysql --host=mysql -u root dime < ./env/fixtures/dime.sql
cp ./app/config/parameters.yml.dist ./app/config/parameters.yml
cp ./web/.htaccess_dev ./web/.htaccess

# init app
php app/console assetic:dump
php app/console asset:install --symlink

# dart-sdk: pub get
/var/www/html/env/pubget.sh

# update supervisor configuration
if [ -f /var/www/html/.docker/supervisord.conf ]; then
	cp /var/www/html/.docker/supervisord.conf /var/www/html/supervisord.conf
fi

if [ -f /var/www/html/supervisord.conf ]; then
	echo "===> detected supervisord.conf in project root"
	echo -e "\n" >> /etc/supervisor/supervisord.conf
    cat /var/www/html/supervisord.conf >> /etc/supervisor/supervisord.conf
fi


# setup cron
if [ `whoami` = 'root' ]; then
    if [ "$GIT_BRANCH" == 'develop' ] || [ "$GIT_BRANCH" == 'master' ]; then
        if [ -f /var/www/html/.docker/crontab ]; then
            cp /var/www/html/.docker/crontab /var/www/html/crontab
        fi

        if [ -f /var/www/html/crontab ]; then
            echo "===> detected crontab in project root"
            crontab /var/www/html/crontab
            crontab -l
            echo "" >> /etc/supervisor/supervisord.conf
            echo "[program:cron]" >> /etc/supervisor/supervisord.conf
            echo "command=cron -f -L 15" >> /etc/supervisor/supervisord.conf
            echo "autostart=true" >> /etc/supervisor/supervisord.conf
            echo "autorestart=true" >> /etc/supervisor/supervisord.conf
        fi
    fi
fi

echo -e "===> generated supervisord configuration:\n"
cat /etc/supervisor/supervisord.conf
echo -e "\n\n===> starting supervisord..."


# start supervisord!

/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
