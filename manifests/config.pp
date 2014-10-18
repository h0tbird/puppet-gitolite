class gitolite::config inherits gitolite {

  file {

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

    "/home/${git_user}/.gitolite.rc":
      ensure  => present,
      content => template("${module_name}/gitolite.rc.erb"),
      owner   => $git_user,
      group   => $git_user,
      mode    => '0640',
      require => Exec['gitolite_setup'],
      notify  => Service['gitolite'];
  }
}
