class nagios::params {

  $nagios_version = 'present'
  $broker_modules = []

  if $::operatingsystem == 'Ubuntu' {
    $nagios_package_name = 'nagios3'
    $nagios_service = 'nagios3'
    $nagios_dir = '/etc/nagios3'
    $nagios_command = '/usr/sbin/nagios3'
    $nagios_resource_dir = "${nagios_dir}/conf.d"
    $nagios_log_dir = '/var/log/nagios3'
    $nagios_cache_dir = '/var/cache/nagios3'
    $nagios_lib_dir = '/var/lib/nagios3'
    $nagios_run_dir = '/var/run/nagios3'
    $nagios_spool_dir = "${nagios_lib_dir}/spool"
    $nagios_htdocs_dir = '/usr/share/nagios3/htdocs'
    $plugins_dir = '/usr/lib/nagios/plugins'

    $cfg_files = [ ]
    $cfg_dirs = [ $nagios_resource_dir ]

  } else {
    fail("Unsupported operatingsystem: ${::operatingsystem}")
  }

  # Default configuration

  $default_contacts = {
    'nagios'                          => {
      'alias'                         => 'Nagios user',
      'service_notification_period'   => '24x7',
      'host_notification_period'      => '24x7',
      'service_notification_options'  => 'w,u,c,r',
      'host_notification_options'     => 'd,r',
      'service_notification_commands' => 'notify-service-by-email',
      'host_notification_commands'    => 'notify-host-by-email',
      'email'                         => 'nagios@localhost',
    }
  }

  $default_contactgroups = {
    'admins'     => {
      'alias'   => 'Nagios Administrators',
      'members' => 'nagios',
    }
  }

  $default_hosts = {
    'generic-host'                   => {
      'notifications_enabled'        => '1',
      'event_handler_enabled'        => '1',
      'flap_detection_enabled'       => '1',
      'failure_prediction_enabled'   => '1',
      'process_perf_data'            => '1',
      'retain_status_information'    => '1',
      'retain_nonstatus_information' => '1',
      'check_command'                => 'check-host-alive',
      'max_check_attempts'           => '10',
      'notification_interval'        => '0',
      'notification_period'          => '24x7',
      'notification_options'         => 'd,u,r',
      'contact_groups'               => 'admins',
      'register'                     => '0',
    }
  }

  $default_services = {
    'generic-service'                => {
      'active_checks_enabled'        => '1',
      'passive_checks_enabled'       => '1',
      'parallelize_check'            => '1',
      'obsess_over_service'          => '1',
      'check_freshness'              => '0',
      'notifications_enabled'        => '1',
      'event_handler_enabled'        => '1',
      'flap_detection_enabled'       => '1',
      'failure_prediction_enabled'   => '1',
      'process_perf_data'            => '1',
      'retain_status_information'    => '1',
      'retain_nonstatus_information' => '1',
      'notification_interval'        => '0',
      'is_volatile'                  => '0',
      'check_period'                 => '24x7',
      'normal_check_interval'        => '5',
      'retry_check_interval'         => '1',
      'max_check_attempts'           => '4',
      'notification_period'          => '24x7',
      'notification_options'         => 'w,u,c,r',
      'contact_groups'               => 'admins',
      'register'                     => '0',
    }
  }

  $default_hostgroups = {
    'all'       => {
      'alias'   => 'All Servers',
      'members' => '*',
    },
  }

  $default_timeperiods = {
    '24x7'        => {
      'alias'     => '24 Hours A Day, 7 Days A Week',
      'sunday'    => '00:00-24:00',
      'monday'    => '00:00-24:00',
      'tuesday'   => '00:00-24:00',
      'wednesday' => '00:00-24:00',
      'thursday'  => '00:00-24:00',
      'friday'    => '00:00-24:00',
      'saturday'  => '00:00-24:00',
    },
    'workhours'   => {
      'alias'     => 'Standard Work Hours',
      'monday'    => '09:00-17:00',
      'tuesday'   => '09:00-17:00',
      'wednesday' => '09:00-17:00',
      'thursday'  => '09:00-17:00',
      'friday'    => '09:00-17:00',
    },
    'nonworkhours' => {
      'alias'      => 'Non-Work Hours',
      'sunday'     => '00:00-24:00',
      'monday'     => '00:00-09:00,17:00-24:00',
      'tuesday'    => '00:00-09:00,17:00-24:00',
      'wednesday'  => '00:00-09:00,17:00-24:00',
      'thursday'   => '00:00-09:00,17:00-24:00',
      'friday'     => '00:00-09:00,17:00-24:00',
      'saturday'   => '00:00-24:00',
    },
    'never'    => {
      'alias'  => 'Never',
    },
  }

  $default_commands = {
  }

}
