set -x
SCRIPT=$(realpath $0)
SCRIPT_PATH=$(basename $SCRIPT)
APP_PATH=$(realpath $SCRIPT_PATH/..)
php $APP_PATH/app/console doc:data:drop --force
php $APP_PATH/app/console doc:data:create
php $APP_PATH/app/console doc:schema:create
php $APP_PATH/app/console doc:fix:load -n
