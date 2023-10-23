# configures an ubuntu server using puppet as follows:
# apt-get update
# apt-get install nginx
# set X-Served-By -> $HOSTNAME
# service restart

# updating the ubuntu server
exec { 'update ubuntu':
  command  => 'apt-get update',
  user     => 'root',
  provider => 'shell',
}
->
# ensure that nginx is installed
package { 'nginx_server':
  ensure   => present,
  provider => 'apt',
}
->
# add a nginx response header (X-Served-By: hostname)
file_line { 'add HTTP header':
  ensure => 'present',
  path   => '/etc/nginx/sites-available/default',
  after  => 'listen 80 default_server;',
  line   => 'add_header X-Served-By $hostname;',
}
->
# start service
service { 'nginx':
  ensure  => 'running',
  enable  => true,
  require => Package['nginx'],
}
