class nagios::plugins (
  $plugins_packages = $::nagios::params::plugins_packages,
  $nagios_service = $::nagios::params::nagios_service,
) inherits nagios::params {
  package { $plugins_packages:
    ensure => installed,
    before => Service[$nagios_service],
  }
}
