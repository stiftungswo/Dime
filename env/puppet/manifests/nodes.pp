node default {
	# simple apache based web server with php and mysql

	include augeasproviders

	# defaults
	Sshd_config { notify => Service[ 'sshd' ] }

	service { 'sshd':
	    ensure => 'running',
	    enable => 'true',
	}

	# sshd config
	#
	sshd_config { 'LoginGraceTime':
	    value  => '30s',
	}

	sshd_config { 'AllowTcpForwarding':
	    value => 'yes',
	}

	sshd_config { 'PermitRootLogin':
	    value  => 'yes',
	}

	sshd_config { 'AllowUsers':
	    value  => [ 'root', 'vagrant' ],
	}

	sshd_config { 'MaxAuthTries':
	    value  => '3',
	}

	sshd_config { 'PasswordAuthentication':
	    value  => 'yes',
	}

	# Setup sudo
	file { 'sudo_wheel':
	    tag     => 'setup',
	    path    => '/etc/sudoers.d/99_wheel',
	    owner   => 'root', group => 'root', mode => '0440',
	    content => "%wheel ALL = (ALL) ALL\n",
	}

	augeas { 'sudo_include_dir':
	    tag     => 'setup',
	    context => '/files/etc/sudoers',
	    changes => 'set #includedir "/etc/sudoers.d"',
	}
	
	class { 'mysql::server':
		package_name	=> 'mariadb-server',
		root_password    => 'testpw',
		service_name	=> 'mariadb',
		override_options => {
 				 'mysqld' => {
    					'datadir' => '/var/lib/mysql',
					'socket'  => '/var/lib/mysql/mysql.sock',
					'symbolic-links' => '0',
					'log-error' => '/var/log/mariadb/mariadb.log',
					'pid-file' => '/var/run/mariadb/mariadb.pid',
  				},
				'mysqld_safe' => {
					'log-error' => '/var/log/mariadb/mariadb.log',
					'socket'  => '/var/lib/mysql/mysql.sock',
					'pid-file' => '/var/run/mariadb/mariadb.pid',
				}
		}
	}
	class {'mysql::bindings':
		php_enable      => true,
	}
	class {'mysql::client':
		package_name	=> 'mariadb',
	}
	mysql::db { 'dime':
	      user     => 'dime',
	      password => 'dime',
	      host     => 'localhost',
	      charset => 'utf8',
	      grant    => ['ALL', ],
	}
	class { 'apache': 
		mpm_module => 'prefork',
	}
	class {'apache::mod::php':}
	apache::vhost { 'dime.test.local':
	      port          => '80',
	      docroot       => '/vagrant/web',
	      docroot_owner => 'vagrant',
	      docroot_group => 'vagrant',
	      serveraliases    => [ $ipaddress, ],
	}
	
	package {[ 'php','php-pear', 'php-mbstring', 'php-intl', 'php-xml', 'php-pecl-xdebug', 'php-pecl-apcu', 'php-process', 'php-gd', 'php-mcrypt', ]:}
    # Set development values to our php.ini and xdebug.ini
    augeas { 'set-php-ini-values':
         context => '/files/etc/php.ini',
         changes => [
             'set PHP/error_reporting "E_ALL | E_STRICT"',
             'set PHP/display_errors On',
             'set PHP/display_startup_errors On',
             'set PHP/html_errors On',
             'set PHP/realpath_cache_size 4096k',
             'set PHP/realpath_cache_ttl 7200',
             'set Date/date.timezone Europe/Zurich',
         ],
         require => Package['php'],
         notify  => Service['httpd'],
    }

     augeas { 'set-xdebug-ini-values':
         context => '/files/etc/php.d/xdebug.ini',
         changes => [
             'set Xdebug/xdebug.remote_enable 1',
             'set Xdebug/xdebug.remote_connect_back 1',
             'set Xdebug/xdebug.remote_port 9000',
             'set Xdebug/xdebug.remote_autostart 0',
             'set Xdebug/xdebug.remote_log /vagrant/xdebug.log',
             'set Xdebug/xdebug.max_nesting_level 250',
         ],
         require => Package['php'],
         notify  => Service['httpd'],
     }
     
     file {'/tmp/app/cache':
     	owner => 'apache',
     	group => 'vagrant',
     	mode => '777',
     }
     
     file {'/tmp/app/log':
     	owner => 'apache',
     	group => 'vagrant',
     	mode => '777',
     }
}
