#!/bin/bash

if [ ! -f $HOME/.ssh/id_rsa ]; then
  echo "Setting up SSH key"
  ./CI/establish-ssh.sh
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

#Read config env
export $(ssh $TARGET "cat dime.$ENVIRONMENT.env" | xargs)

TMP=dime_deploy_tmp
BACKUP_DIR=backup/dime/$ENVIRONMENT

if [ -z "$PROJECT_DIR" ]; then
  echo "PROJECT_DIR is not set"
  exit 1
fi

rsync -ra --exclude '.git' --exclude '.pub-cache' . $TARGET:$TMP && \
ssh $TARGET rm -r ${PROJECT_DIR}.bak && \
ssh $TARGET mv $PROJECT_DIR ${PROJECT_DIR}.bak && \
ssh $TARGET mv $TMP $PROJECT_DIR

ssh $TARGET cp $CONFIG_FILE $PROJECT_DIR/app/config/parameters.yml

ssh $TARGET mkdir -p $BACKUP_DIR
ssh $TARGET "mysqldump -u $DATABASE_USER -p\"$DATABASE_PW\" $DATABASE | bzip2 -c > $BACKUP_DIR/$DATABASE_$(date +%Y-%m-%d-%H.%M.%S).sql.bz2"
ssh $TARGET "cd $PROJECT_DIR && php71 app/console doctrine:migrations:migrate --no-interaction"
