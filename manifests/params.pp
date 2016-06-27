class ntp::params {
  if str2bool($facts['is_virtual']) {
    $tinker = true
    $panic  = 0
  }
  else {
    $tinker = false
    $panic  = undef
  }
}
