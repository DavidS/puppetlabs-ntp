define ntp::key (
  $content = undef,
  $source  = undef,
  $owner   = 0,
  $group   = 0,
  $mode    = '0664',
  )
{
  include ntp::params
  include ntp::skel::key_dir

  file { $ntp::params::keys_file:
    ensure  => file,
    content => $content,
    source  => $source,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    notify  => Service['ntp'],
  }
}
