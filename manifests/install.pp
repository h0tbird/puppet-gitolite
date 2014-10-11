class gitolite::install inherits gitolite {

  package { 'gitolite3':
    ensure => $version,
  } ->

  group { $git_user:
    ensure => present,
  } ->

  user { $git_user:
    ensure     => present,
    gid        => $git_user,
    groups     => 'gitolite3',
    home       => "/home/${git_user}",
    managehome => true,
    shell      => '/sbin/nologin',
    require    => Package['gitolite3'],
  } ->

  file { "/home/${git_user}/gitolite.key.pub":
    ensure  => present,
    content => $ssh_key,
    owner   => $git_user,
    group   => $git_user,
    mode    => '0640',
  } ->

  file { "/home/${git_user}/${git_admin}.pub":
    ensure => link,
    target => "/home/${git_user}/gitolite.key.pub",
    owner  => $git_user,
    group  => $git_user,
  } ->

  exec { 'gitolite_setup':
    command     => "gitolite setup -pk ${git_admin}.pub",
    provider    => 'shell',
    environment => ["HOME=/home/${git_user}"],
    cwd         => "/home/${git_user}",
    creates     => "/home/${git_user}/.gitolite",
  }
}
