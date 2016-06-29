class ntp (
  Boolean $broadcastclient,
  Tea::Absolutepath $config,
  Optional[Tea::Absolutepath] $config_dir,
  String $config_file_mode,
  String[1] $config_template,
  Boolean $disable_auth,
  Boolean $disable_dhclient,
  Boolean $disable_kernel,
  Boolean $disable_monitor,
  Optional[Array[String]] $fudge,
  Tea::Absolutepath $driftfile,
  Optional[Tea::Absolutepath] $leapfile,
  Optional[Tea::Absolutepath] $logfile,
  Boolean $iburst_enable,
  Array[String] $keys,
  Boolean $keys_enable,
  Tea::Absolutepath $keys_file,
  Optional[Ntp::Key_id] $keys_controlkey,
  Optional[Ntp::Key_id] $keys_requestkey,
  Optional[Array[Ntp::Key_id]] $keys_trusted,
  Optional[Ntp::Poll_interval] $minpoll,
  Optional[Ntp::Poll_interval] $maxpoll,
  String $package_ensure,
  Boolean $package_manage,
  Array[String] $package_name,
  Boolean $panic                                  = $ntp::params::panic,
  Array[String] $peers,
  Array[String] $preferred_servers,
  Array[String] $restrict,
  Array[String] $interfaces,
  Array[String] $interfaces_ignore,
  Array[String] $servers,
  Boolean $service_enable,
  String $service_ensure,
  Boolean $service_manage,
  String $service_name,
  String $service_provider,
  Optional[Integer[0, 65535]] $stepout,
  Optional[Tea::Absolutepath] $step_tickers_file,
  Optional[String] $step_tickers_template,
  Boolean $tinker                                 = $ntp::params::tinker,
  Boolean $tos,
  Optional[Integer[1]] $tos_minclock,
  Optional[Integer[1]] $tos_minsane,
  Optional[Integer[1]] $tos_floor,
  Optional[Integer[1]] $tos_ceiling,
  Variant[Boolean, Integer[0,1]] $tos_cohort,
  Boolean $udlc,
  Optional[Integer[1,15]] $udlc_stratum,
  Optional[Tea::Absolutepath] $ntpsigndsocket,
  Optional[String] $authprov,
) inherits ntp::params {
  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'ntp::begin': } ->
  class { '::ntp::install': } ->
  class { '::ntp::config': } ~>
  class { '::ntp::service': } ->
  anchor { 'ntp::end': }

}
