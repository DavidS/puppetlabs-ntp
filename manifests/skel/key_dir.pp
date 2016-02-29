class ntp::skel::key_dir inherits ntp::params {
  case $ntp::params::config_dir {
    '/', '/etc', undef: {}
    default: {
      file { $ntp::params::config_dir:
        ensure  => directory,
        owner   => 0,
        group   => 0,
        mode    => '0664',
        recurse => false,
      }
    }
  }
}
