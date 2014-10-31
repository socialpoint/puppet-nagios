class nagios (
  $nagios_package_name = $::nagios::params::nagios_package_name,
  $nagios_version = $::nagios::params::nagios_version,
  $nagios_service = $::nagios::params::nagios_service,

  $nagios_dir = $::nagios::params::nagios_dir,
  $nagios_command = $::nagios::params::nagios_command,
  $nagios_resource_dir = $::nagios::params::nagios_resource_dir,
  $nagios_log_dir = $::nagios::params::nagios_log_dir,
  $nagios_cache_dir = $::nagios::params::nagios_cache_dir,
  $nagios_lib_dir = $::nagios::params::nagios_lib_dir,
  $nagios_run_dir = $::nagios::params::nagios_run_dir,
  $nagios_spool_dir = $::nagios::params::nagios_spool_dir,
  $nagios_htdocs_dir = $::nagios::params::nagios_htdocs_dir,
  $plugins_dir = $::nagios::params::plugins_dir,

  $default_contacts = $::nagios::params::default_contacts,
  $default_contactgroups = $::nagios::params::default_contactgroups,
  $default_hosts = $::nagios::params::default_hosts,
  $default_hostgroups = $::nagios::params::default_hostgroups,
  $default_services = $::nagios::params::default_services,
  $default_timeperiods = $::nagios::params::default_timeperiods,

  $collect_exported_resources = true,
  $exported_resources_tag = undef,
  $extra_cfg_files = [],
  $extra_cfg_dirs = [],
  $broker_modules = [],
) inherits nagios::params {

  package { $nagios_package_name:
    ensure => $nagios_version,
  }

  service { $nagios_service:
    ensure  => running,
    enable  => true,
    require => Package[$nagios_package_name],
  }

  ### Exported resources

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

  ### Resource defaults

  Nagios_command{
    require => File["${nagios_resource_dir}/command"],
    notify  => Service[$nagios_service],
  }
  Nagios_contactgroup{
    require => File["${nagios_resource_dir}/contactgroup"],
    notify  => Service[$nagios_service],
  }
  Nagios_contact{
    require => File["${nagios_resource_dir}/contact"],
    notify  => Service[$nagios_service],
  }
  Nagios_hostdependency{
    require => File["${nagios_resource_dir}/hostdependency"],
    notify  => Service[$nagios_service],
  }
  Nagios_hostescalation{
    require => File["${nagios_resource_dir}/hostescalation"],
    notify  => Service[$nagios_service],
  }
  Nagios_hostextinfo{
    require => File["${nagios_resource_dir}/hostextinfo"],
    notify  => Service[$nagios_service],
  }
  Nagios_hostgroup{
    require => File["${nagios_resource_dir}/hostgroup"],
    notify  => Service[$nagios_service],
  }
  Nagios_host{
    require => File["${nagios_resource_dir}/host"],
    notify  => Service[$nagios_service],
  }
  Nagios_servicedependency{
    require => File["${nagios_resource_dir}/servicedependency"],
    notify  => Service[$nagios_service],
  }
  Nagios_serviceescalation{
    require => File["${nagios_resource_dir}/serviceescalation"],
    notify  => Service[$nagios_service],
  }
  Nagios_serviceextinfo{
    require => File["${nagios_resource_dir}/serviceextinfo"],
    notify  => Service[$nagios_service],
  }
  Nagios_servicegroup{
    require => File["${nagios_resource_dir}/servicegroup"],
    notify  => Service[$nagios_service],
  }
  Nagios_service{
    require => File["${nagios_resource_dir}/service"],
    notify  => Service[$nagios_service],
  }
  Nagios_timeperiod{
    require => File["${nagios_resource_dir}/timeperiod"],
    notify  => Service[$nagios_service],
  }
  Ini_setting{
    section => '',
    require => Package[$nagios_package_name],
    notify  => Service[$nagios_service],
  }

  ### Config files and dirs

  # XXX: We cannot use the "resources" resource to purge non created nagios
  # resources because of an historic limitation so we workaround it
  file {[
          $nagios_resource_dir,
          "${nagios_resource_dir}/command",
          "${nagios_resource_dir}/contactgroup",
          "${nagios_resource_dir}/contact",
          "${nagios_resource_dir}/hostdependency",
          "${nagios_resource_dir}/hostescalation",
          "${nagios_resource_dir}/hostextinfo",
          "${nagios_resource_dir}/hostgroup",
          "${nagios_resource_dir}/host",
          "${nagios_resource_dir}/servicedependency",
          "${nagios_resource_dir}/serviceescalation",
          "${nagios_resource_dir}/serviceextinfo",
          "${nagios_resource_dir}/servicegroup",
          "${nagios_resource_dir}/service",
          "${nagios_resource_dir}/timeperiod",
        ]:
    ensure  => directory,
    purge   => true,
    recurse => true,
    require => Package[$nagios_package_name],
  }

  $cfg_dirs = union($extra_cfg_dirs, $::nagios::params::cfg_dirs)
  $cfg_files = union($extra_cfg_files, $::nagios::params::cfg_files)

  file { "${nagios_dir}/nagios.cfg":
    ensure  => present,
    owner   => 'nagios',
    group   => 'nagios',
    mode    => '0644',
    content => template('nagios/nagios.cfg.erb'),
    require => Package[$nagios_package_name],
    notify  => Service[$nagios_service],
  }

  file { "${nagios_dir}/cgi.cfg":
    ensure  => present,
    owner   => 'nagios',
    group   => 'nagios',
    mode    => '0644',
    content => template('nagios/cgi.cfg.erb'),
    require => Package[$nagios_package_name],
    notify  => Service[$nagios_service],
  }


  ### Default configuration

  nagios::resource_hash::contact { $default_contacts: }
  nagios::resource_hash::contactgroup { $default_contactgroups: }
  nagios::resource_hash::host { $default_hosts: }
  nagios::resource_hash::service { $default_services: }
  nagios::resource_hash::hostgroup { $default_hostgroups: }
  nagios::resource_hash::timeperiod { $default_timeperiods: }

}
