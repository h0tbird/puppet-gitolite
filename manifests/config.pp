class gitolite::config inherits gitolite {

  file { "/home/${git_user}/.gitolite.rc":
    ensure  => present,
    content => template("${module_name}/gitolite.rc.erb"),
    owner   => $git_user,
    group   => $git_user,
    mode    => '0640',
    require => Exec['gitolite_setup'],
  }
}
