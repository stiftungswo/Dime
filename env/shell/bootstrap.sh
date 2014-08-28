#!/bin/sh

# Directory in which librarian-puppet should manage its modules directory
PUPPET_DIR='/vagrant/env/puppet'
MODULE_DIR='/var/tmp/puppet/modules'

# NB: librarian-puppet might need git installed. If it is not already installed
# in your basebox, this will manually install it at this point using apt or yum
GIT=/usr/bin/git
APT_GET=/usr/bin/apt-get
YUM=/usr/bin/yum
if [ ! -x $GIT ]; then
    if [ -x $YUM ]; then
        yum -q -y install git-core
    elif [ -x $APT_GET ]; then
        apt-get -q -y install git-core
    else
        echo "No package installer available. You may need to install git manually."
    fi
fi

echo "export PATH=$PATH:/usr/local/bin" > /etc/profile.d/localbin.sh
source /etc/profile.d/localbin.sh

test -d $MODULE_DIR || mkdir -p $MODULE_DIR

if [ `gem query --local | grep librarian-puppet | wc -l` -eq 0 ]; then
	gem install librarian-puppet -v 1.0.3
	cd $PUPPET_DIR && librarian-puppet install --clean --path=$MODULE_DIR
else
	cd $PUPPET_DIR && librarian-puppet install --path=$MODULE_DIR
fi

# now we run puppet
puppet apply -v  --modulepath=$MODULE_DIR $PUPPET_DIR/manifests/main.pp
