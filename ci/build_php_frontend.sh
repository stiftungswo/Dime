#!/bin/bash -vue
php app/console assetic:dump
php app/console asset:install --symlink --relative
