class ntp::policy::disable_dhclient_integration {
  augeas { 'disable ntp-servers in dhclient.conf':
    context => '/files/etc/dhcp/dhclient.conf',
    changes => 'rm request/*[.="ntp-servers"]',
  }

  file { '/var/lib/ntp/ntp.conf.dhcp':
    ensure => absent,
  }
}
