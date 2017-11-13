#!/bin/bash -x
./CI/establish-ssh.sh
rsync -rav --exclude '.git' --exclude '.pub-cache' . $TARGET:test_bla
