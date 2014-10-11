class gitolite (

  $version   = undef,
  $git_user  = undef,
  $git_admin = undef,
  $ssh_key   = undef,

) {

  contain "${module_name}::install"
  contain "${module_name}::config"
}
