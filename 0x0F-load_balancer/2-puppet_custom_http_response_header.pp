# configures an ubuntu server using puppet as follows:
# apt-get update
# apt-get install nginx
# set X-Served-By -> $HOSTNAME
# service restart

# updating the ubuntu server
exec { '/usr/bin/env apt-get -y update' : }
-> package { 'nginx' :
  ensure => installed,
}
# add a nginx response header (X-Served-By: hostname)
-> file { '/var/www/html/index.html' :
  content => 'Holberton School!',
}
-> file_line { 'add header':
  ensure => present,
  path   => '/etc/nginx/sites-available/default',
  after  => 'server_name _;',
  line   => '\tadd_header X-Served-By ${hostname};',
}
->
# start service
service { 'nginx':
  ensure  => 'running',
}
