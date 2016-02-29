define ntp::config (
  $content = undef,
  $source  = undef,
  $owner   = 'ntp',
  $group   = 'ntp',
  $mode    = '0664',
  )
{
  include ntp::params

  file { $ntp::params::config:
    ensure  => file,
    content => $content,
    source  => $source,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
  }
}
