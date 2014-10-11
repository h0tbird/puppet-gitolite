class gitolite::config inherits gitolite {

  file { "/home/${git_user}/.gitolite.rc":
    ensure  => present,
    owner   => $git_user,
    group   => $git_user,
    mode    => template("${module_name}/gitolite.rc.erb"),
    require => Exec['gitolite_setup'],
  }
}
