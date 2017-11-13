wget -q https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.2/sdk/dartsdk-linux-x64-release.zip && \
unzip -q dartsdk-linux-x64-release.zip && \
cd src/Dime/FrontendBundle/Resources/public && \
../../../../../dart-sdk/bin/pub get --packages-dir && \
../../../../../dart-sdk/bin/pub build
