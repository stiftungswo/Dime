#!/bin/bash -vue

if [ ! -f dart-sdk/bin/pub ]; then
  wget -q https://storage.googleapis.com/dart-archive/channels/stable/release/2.0.0/sdk/dartsdk-linux-x64-release.zip && \
  unzip -q dartsdk-linux-x64-release.zip
fi
