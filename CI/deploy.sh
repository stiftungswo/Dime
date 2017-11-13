#!/bin/bash -x
./CI/establish-ssh.sh
scp -r . $TARGET:test_bla
