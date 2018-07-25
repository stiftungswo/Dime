#!/bin/bash -vue

if [ ! -f dart-sdk/bin/pub ]; then
  #todo replace with stable release once ready wget -q https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.2/sdk/dartsdk-linux-x64-release.zip && \
  wget -q https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.69.2/sdk/dartsdk-macos-x64-release.zip && \
  unzip -q dartsdk-linux-x64-release.zip
fi
