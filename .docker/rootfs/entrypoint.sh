#!/usr/bin/env bash

# setup
composer install
/var/www/html/env/db_rebuild.sh

# dev environment config
cp ./app/config/parameters.yml.dist ./app/config/parameters.yml
cp ./web/.htaccess_dev ./web/.htaccess

/var/www/html/env/install_bundles.sh
/var/www/html/env/pub_get.sh

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
