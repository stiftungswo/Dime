#!/bin/bash -x

cd src/Dime/FrontendBundle/Resources/public && \
../../../../../dart-sdk/bin/pub get --packages-dir && \
../../../../../dart-sdk/bin/pub build
