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
    managehome => false,
    shell      => '/bin/bash',
    require    => Package['gitolite3'],
  } ->

  file {

    "/home/${git_user}":
      ensure => directory,
      owner  => $git_user,
      group  => $git_user,
      mode   => '0700';

    "/home/${git_user}/gitolite.key.pub":
      ensure  => present,
      content => $ssh_key,
      owner   => $git_user,
      group   => $git_user,
      mode    => '0640';

    "/home/${git_user}/${git_admin}.pub":
      ensure => link,
      target => "/home/${git_user}/gitolite.key.pub",
      owner  => $git_user,
      group  => $git_user;
  } ->

  exec { 'gitolite_setup':
    command     => "gitolite setup -pk ${git_admin}.pub",
    user        => $git_user,
    provider    => 'shell',
    environment => ["HOME=/home/${git_user}"],
    cwd         => "/home/${git_user}",
    creates     => "/home/${git_user}/.gitolite",
  } ->

  file {

    [ "/home/${git_user}/.gitolite/local",
    "/home/${git_user}/.gitolite/local/hooks",
    "/home/${git_user}/.gitolite/local/hooks/repo-specific" ]:
      ensure => directory,
      owner  => $git_user,
      group  => $git_user,
      mode   => '0700';

    '/etc/systemd/system/gitolite.service':
      ensure  => present,
      content => template("${module_name}/gitolite.service.erb"),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      notify  => Service['gitolite'];

    '/usr/bin/gitolite-bootstrap':
      ensure  => present,
      content => template("${module_name}/gitolite-bootstrap.erb"),
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      notify  => Service['gitolite'];
  }
}
