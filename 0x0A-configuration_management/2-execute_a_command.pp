# manifest that kills a process named killmenow

exec { 'killmenow':
  command => '/usr/bin/pkill -9 killmenow',
}
