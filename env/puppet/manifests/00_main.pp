Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }
File { owner => 0, group => 0, mode => '0644' }
stage { 'first': }
stage { 'last': }
Stage['first'] -> Stage['main'] -> Stage['last']

class{'basic':
  stage => first
}