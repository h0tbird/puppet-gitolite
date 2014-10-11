class gitolite (

  $version   = undef,
  $git_user  = undef,
  $git_admin = undef,
  $ssh_key   = undef,

) {

  contains "${module_name}::install"
  contains "${module_name}::config"
}
