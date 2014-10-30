class nagios (
  $nagios_package_name = $::nagios::params::nagios_package_name,
  $nagios_version = $::nagios::params::nagios_version,
  $nagios_service = $::nagios::params::nagios_service,
  $nagios_dir = $::nagios::params::nagios_dir,
  $nagios_resource_dir = $::nagios::params::nagios_resource_dir,
  $default_config_files = $::nagios::params::default_config_files,
  $default_contacts = $::nagios::params::default_contacts,
  $default_contactgroups = $::nagios::params::default_contactgroups,
  $default_hosts = $::nagios::params::default_hosts,
  $default_hostgroups = $::nagios::params::default_hostgroups,
  $default_services = $::nagios::params::default_services,
  $default_timeperiods = $::nagios::params::default_timeperiods,
  $collect_exported_resources = true,
  $exported_resources_tag = undef,
) inherits nagios::params {

  package { $nagios_package_name:
    ensure => $nagios_version,
  }

  service { $nagios_service:
    ensure  => running,
    enable  => true,
    require => Package[$nagios_package_name],
  }

  if $collect_exported_resources {
    Nagios_servicedependency <<| tag == $exported_resources_tag |>> {
      notify  => Service[$nagios_service],
      require => Package[$nagios_package_name],
    }
    Nagios_service <<| tag == $exported_resources_tag |>> {
      notify  => Service[$nagios_service],
      require => Package[$nagios_package_name],
    }
    Nagios_host <<| tag == $exported_resources_tag |>> {
      notify  => Service[$nagios_service],
      require => Package[$nagios_package_name],
    }
  }

  Nagios_contact {
    require => File[$nagios_resource_dir],
  }
  Nagios_contactgroup{
    require => File[$nagios_resource_dir],
  }
  Nagios_host{
    require => File[$nagios_resource_dir],
  }
  Nagios_service{
    require => File[$nagios_resource_dir],
  }
  Nagios_hostgroup{
    require => File[$nagios_resource_dir],
  }
  Nagios_timeperiod{
    require => File[$nagios_resource_dir],
  }

  # XXX: We cannot use the "resources" resource to purge non created nagios
  # resources because of an historic limitation so we workaround it
  file { $nagios_resource_dir:
    ensure  => directory,
    purge   => true,
    recurse => true,
    require => Package[$nagios_package_name],
  }

  # Create default configuration
  nagios::resource::contact { $default_contacts: }
  nagios::resource::contactgroup { $default_contactgroups: }
  nagios::resource::host { $default_hosts: }
  nagios::resource::service { $default_services: }
  nagios::resource::hostgroup { $default_hostgroups: }
  nagios::resource::timeperiod { $default_timeperiods: }

}
