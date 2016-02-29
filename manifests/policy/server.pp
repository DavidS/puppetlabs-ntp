class ntp::policy::server
{
  include ntp::policy::disable_dhclient_integration

  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'ntp::begin': } ->
  class { '::ntp::skel': } ->
  anchor { 'ntp::end': }

  ntp::config {
    'default':
      source => 'puppet:///modules/ntp/server.conf',
  }
}
