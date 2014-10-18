class gitolite (

  $version              = undef,
  $git_user             = undef,
  $git_admin            = undef,
  $ssh_key              = undef,
  $umask                = undef,
  $git_config_keys      = undef,
  $gitweb_projects_list = undef,
  $local_code           = undef,
  $cgit                 = undef,
  $repo_specific_hooks  = undef,

) {

  contain "${module_name}::install"
  contain "${module_name}::config"
  contain "${module_name}::service"
}
