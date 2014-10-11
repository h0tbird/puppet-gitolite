class gitolite::config inherits gitolite {

  group { 'git':
    ensure => present,
  } ->

  user { 'git':
    ensure     => present,
    gid        => 'git',
    groups     => 'gitolite3',
    home       => '/home/git',
    managehome => true,
    shell      => '/sbin/nologin',
    require    => Package['gitolite3'],
  } ->

  file { '/home/git/gitolite.key.pub':
    ensure  => present,
    content => $ssh_key,
    owner   => 'git',
    group   => 'git',
    mode    => '0640',
  } ->

  file { '/home/git/marc.pub':
    ensure => link,
    target => '/home/git/gitolite.key.pub',
    owner  => 'git',
    group  => 'git',
  }
}
