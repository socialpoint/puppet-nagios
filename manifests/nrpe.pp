class nagios::nrpe (
  $nrpe_package = $::nagios::params::nrpe_package,
  $nrpe_service = $::nagios::params::nrpe_service,
  $nrpe_dir = $::nagios::params::nrpe_dir,
  $nrpe_config_dir = $::nagios::params::nrpe_config_dir,
  $port = $::nagios::params::nrpe_port,
  $allowed_hosts = '127.0.0.1',
) inherits nagios::params {

  package { $nrpe_package:
    ensure => installed,
  }

  service { $nrpe_service:
    ensure  => running,
    enable  => true,
    require => Package[$nrpe_package],
  }

  file { "${nrpe_dir}/nrpe.cfg":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('nagios/nrpe.cfg.erb'),
    require => Package[$nrpe_package],
    notify  => Service[$nrpe_service],
  }

  file { $nrpe_config_dir:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    purge   => true,
    recurse => true,
    require => Package[$nrpe_package],
    notify  => Service[$nrpe_service],
  }

}
