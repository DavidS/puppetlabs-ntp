# these should go to stdlib
type Ntp::Windowspath = Pattern[/^(([a-zA-Z]:[\\\/])|([\\\/][\\\/][^\\\/]+[\\\/][^\\\/]+)|([\\\/][\\\/]\?[\\\/][^\\\/]+))/]
type Ntp::Absolutepath_compat = Variant[Ntp::Windowspath, Pattern[/^\//]]
type Ntp::Is_absolute_path = Variant[Ntp::Absolutepath_compat, Array[Ntp::Absolutepath_compat]]
type Ntp::Is_numeric_string = Pattern[/^-?(?:(?:[1-9]\d*)|0)(?:\.\d+)?(?:[eE]-?\d+)?$/]
type Ntp::Is_numeric = Variant[Numeric, Ntp::Is_numeric_string]

class ntp (
  Boolean $autoupdate,
  $broadcastclient,
  Ntp::Is_absolute_path $config,
  Optional[Ntp::Is_absolute_path] $config_dir,
  $config_file_mode,
  String $config_template,
  Boolean $disable_auth,
  Boolean $disable_dhclient,
  Boolean $disable_kernel,
  Boolean $disable_monitor,
  Array $fudge,
  Ntp::Is_absolute_path $driftfile,
  Optional[Ntp::Is_absolute_path] $leapfile,
  Optional[Ntp::Is_absolute_path] $logfile,
  Boolean $iburst_enable,
  Array[Any] $keys,
  Boolean $keys_enable,
  $keys_file,
  Variant[Integer, Pattern[/^\d+$/, //]] $keys_controlkey,
  Variant[Integer, Pattern[/^\d+$/, //]] $keys_requestkey,
  Array[Any] $keys_trusted,
  Optional[Variant[Integer[3, 16], Float[3, 16], Ntp::Is_numeric_string]] $minpoll,
  Optional[Variant[Integer[3, 16], Float[3, 16], Ntp::Is_numeric_string]] $maxpoll,
  String $package_ensure,
  Boolean $package_manage,
  Array[Any] $package_name,
  Optional[Variant[Integer[0, 65535], Ntp::Is_numeric_string]] $panic = $::ntp::params::panic,
  Optional[Any] $peers,
  Array[Any] $preferred_servers,
  Array[Any] $restrict,
  Array[Any] $interfaces,
  $interfaces_ignore,
  Array[Any] $servers,
  Boolean $service_enable,
  String $service_ensure,
  $service_manage,
  $service_name,
  Optional[Any] $service_provider,
  Optional[Variant[Integer[0, 65535], Ntp::Is_numeric_string]] $stepout,
  Optional[String] $step_tickers_file,
  Optional[String] $step_tickers_template,
  Boolean $tinker = $::ntp::params::tinker,
  Boolean $tos,
  Optional[Ntp::Is_numeric] $tos_minclock,
  Optional[Ntp::Is_numeric] $tos_minsane,
  Optional[Ntp::Is_numeric] $tos_floor,
  Optional[Ntp::Is_numeric] $tos_ceiling,
  Optional[Variant[Integer[0, 1], Pattern['^[0|1]$']]] $tos_cohort,
  Boolean $udlc,
  $udlc_stratum,
  Optional[Ntp::Is_absolute_path] $ntpsigndsocket,
  Optional[String] $authprov,
) inherits ntp::params {

  if $minpoll { validate_numeric($minpoll, 16, 3) }
  if $maxpoll { validate_numeric($maxpoll, 16, 3) }
  if $panic { validate_numeric($panic, 65535, 0) }
  if $stepout { validate_numeric($stepout, 65535, 0) }

  if $autoupdate {
    notice('autoupdate parameter has been deprecated and replaced with package_ensure.  Set package_ensure to latest for the same behavior as autoupdate => true.')
  }

  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'ntp::begin': } ->
  class { '::ntp::install': } ->
  class { '::ntp::config': } ~>
  class { '::ntp::service': } ->
  anchor { 'ntp::end': }

}
