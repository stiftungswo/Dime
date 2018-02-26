#!/bin/bash -vue

if [ ! -f $HOME/.ssh/id_rsa ]; then
  echo "Setting up SSH key"
  ./ci/establish-ssh.sh
fi

case $1 in
  "test")
    ENVIRONMENT=test
    ;;
  "prod")
    ENVIRONMENT=prod
    ;;
  *)
    echo "Invalid environment"
    exit 1
    ;;
esac

# This imports the config from $CONFIG_FILE on the remote system ($TARGET) into this scripts environment
export $(ssh $TARGET "cat deploy/dime.$ENVIRONMENT.env" | xargs)

TMP=dime_deploy_tmp_${TRAVIS_BRANCH}_${TRAVIS_COMMIT}
BACKUP_DIR=backup/dime/$ENVIRONMENT

ssh $TARGET mkdir -p ${PROJECT_DIR} ${PROJECT_DIR}.bak
rsync -ra --exclude '.git' --exclude '.pub-cache' --exclude 'dart-sdk' --exclude 'dartsdk-linux-x64-release.zip' . $TARGET:$TMP
ssh $TARGET cp $CONFIG_FILE $TMP/app/config/parameters.yml
echo sed -i'' "s/COMMIT_ID/$TRAVIS_COMMIT/" $TMP/app/config/parameters.yml
ssh $TARGET sed -i'' "s/COMMIT_ID/$TRAVIS_COMMIT/" $TMP/app/config/parameters.yml
echo sed -i'' "s,SENTRY_DSN,$SENTRY_DSN,g" $TMP/src/Dime/FrontendBundle/Resources/public/build/web/main.dart.js
ssh $TARGET sed -i'' "s,SENTRY_DSN,$SENTRY_DSN,g" $TMP/src/Dime/FrontendBundle/Resources/public/build/web/main.dart.js
echo sed -i'' "s/DIME_ENVIRONMENT/$ENVIRONMENT/g" $TMP/src/Dime/FrontendBundle/Resources/public/build/web/main.dart.js
ssh $TARGET sed -i'' "s/DIME_ENVIRONMENT/$ENVIRONMENT/g" $TMP/src/Dime/FrontendBundle/Resources/public/build/web/main.dart.js
echo sed -i'' "s/DIME_RELEASE/$TRAVIS_COMMIT/g" $TMP/src/Dime/FrontendBundle/Resources/public/build/web/main.dart.js
ssh $TARGET sed -i'' "s/DIME_RELEASE/$TRAVIS_COMMIT/g" $TMP/src/Dime/FrontendBundle/Resources/public/build/web/main.dart.js
ssh $TARGET rm -r ${PROJECT_DIR}.bak
ssh $TARGET mv $PROJECT_DIR ${PROJECT_DIR}.bak
ssh $TARGET mv $TMP $PROJECT_DIR

ssh $TARGET "cd $PROJECT_DIR && php72 app/console cache:clear --env=prod"

ssh $TARGET mkdir -p $BACKUP_DIR
ssh $TARGET "mysqldump -u $DATABASE_USER -p\"$DATABASE_PW\" $DATABASE | bzip2 -c > $BACKUP_DIR/${DATABASE}_$(date +%Y-%m-%d-%H.%M.%S).sql.bz2"
ssh $TARGET "cd $PROJECT_DIR && php72 app/console doctrine:migrations:migrate --no-interaction"

