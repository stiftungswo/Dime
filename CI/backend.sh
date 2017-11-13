mysql -e 'create database dime;' && \
cp app/config/parameters.yml.travis app/config/parameters.yml.dist && \
composer install -n && \
php app/console doctrine:schema:create && \
mysql dime < env/fixtures/dime.sql && \
php app/console assetic:dump && \
php app/console asset:install --symlink