# configures and manages NTPd with the default config of the target distribution
class ntp::skel inherits ntp::params {
  package { 'ntp':
    name => $package_name,
    ensure => 'installed',
  }

  service { 'ntp':
    ensure     => $service_ensure,
    enable     => $service_enable,
    name       => $service_name,
    hasstatus  => true,
    hasrestart => true,
  }
}
