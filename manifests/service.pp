class gitolite::service inherits gitolite {

  service { 'gitolite':
    ensure => running,
    enable => true,
  }
}
