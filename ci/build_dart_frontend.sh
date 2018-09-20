#!/bin/bash -vue

cd src/Dime/FrontendBundle/Resources/public
../../../../../dart-sdk/bin/pub get
../../../../../dart-sdk/bin/pub run build_runner build --config=release -o build
