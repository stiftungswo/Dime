class basic{
  # Enable EPEL Repos before everithing else
  #class {'epel': stage => first} ->
  class {"basic::users":} ->
  class {"basic::packages":} ->
  class {"basic::helpers":}
}

class basic::users{
  group { "puppet":
    ensure => "present",
  }
}

# just some packages
class basic::packages{
  package{"curl": ensure => installed}
  package{"vim-enhanced":  ensure => installed}
  exec{'rpm -Uvh https://mirror.webtatic.com/yum/el7/epel-release.rpm':
    before => Exec['webtatic'],
    creates => "/etc/yum.repos.d/epel.repo"
  }
  exec{'rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm':
    alias => 'webtatic',
    creates => "/etc/yum.repos.d/webtatic.repo"
  }
}


class basic::helpers{
  $puppet_dir = "/vagrant/env/puppet"
  $module_dir = "/var/tmp/puppet/modules"
  # script to run puppet
  file{"/usr/local/bin/runpuppet":
    content => " \
    sudo puppet apply -vv  --modulepath=$module_dir $puppet_dir/manifests/main.pp\n",
    mode    => '0755'
  }

  # script to run librarian-puppet
  file{"/usr/local/bin/runlibrarian":
    content => "cd $puppet_dir &&  sudo librarian-puppet install --path=$module_dir \n",
    mode    => '0755'
  }
}

# brings the system up-to-date after importing it with Vagrant
# runs only once after booting (checks /tmp/apt-get-update existence)
#class basic::update_aptget{
#  exec{"apt-get update && touch /tmp/apt-get-updated":
#    unless => "test -e /tmp/apt-get-updated"
#  }
#}
