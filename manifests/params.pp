class nagios::params {

  $nagios_version = 'present'
  $broker_modules = []
  $manage_htpasswd = true
  $authorized_for_system_information = 'nagiosadmin'
  $authorized_for_configuration_information = 'nagiosadmin'
  $authorized_for_system_commands = 'nagiosadmin'
  $authorized_for_all_services = 'nagiosadmin'
  $authorized_for_all_hosts = 'nagiosadmin'

  $nrpe_port = '5666'

  if $::operatingsystem == 'Ubuntu' {
    $nagios_package_name = 'nagios3'
    $apache_user = 'www-data'
    $nrpe_user = 'nagios'
    $apache_service = 'apache2'
    $nagios_service = 'nagios3'
    $nagios_dir = '/etc/nagios3'
    $nagios_command = '/usr/sbin/nagios3'
    $nagios_resource_dir = "${nagios_dir}/conf.d"
    $nagios_log_dir = '/var/log/nagios3'
    $nagios_cache_dir = '/var/cache/nagios3'
    $nagios_lib_dir = '/usr/lib/nagios3'
    $nagios_enable_environment_macros = '1'
    $nagios_varlib_dir = '/var/lib/nagios3'
    $nagios_run_dir = '/var/run/nagios3'
    $nagios_spool_dir = "${nagios_varlib_dir}/spool"
    $nagios_htdocs_dir = '/usr/share/nagios3/htdocs'
    $nagios_stylesheets_dir = "${nagios_dir}/stylesheets"
    $nagios_cgi_dir = '/usr/lib/cgi-bin/nagios3'
    $nagios_external_cmd_dir = "${nagios_varlib_dir}/rw"
    $plugins_dir = '/usr/lib/nagios/plugins'
    $htpasswd_file = "${nagios_dir}/htpasswd.users"
    $html_dir = '/nagios3'

    $nrpe_package = 'nagios-nrpe-server'
    $nrpe_service = 'nagios-nrpe-server'
    $nrpe_dir = '/etc/nagios'
    $nrpe_config_dir = "${nrpe_dir}/nrpe.d"

    $plugins_packages = [
                          'nagios-plugins',
                          'nagios-plugins-basic',
                          'nagios-plugins-contrib',
                          'nagios-nrpe-plugin',
                        ]

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
    'notify-host-by-email' => {
      'command_line' => '/usr/bin/printf "%b" "***** Nagios *****\n\nNotification Type: $NOTIFICATIONTYPE$\nHost: $HOSTNAME$\nState: $HOSTSTATE$\nAddress: $HOSTADDRESS$\nInfo: $HOSTOUTPUT$\n\nDate/Time: $LONGDATETIME$\n" | /usr/bin/mail -s "** $NOTIFICATIONTYPE$ Host Alert: $HOSTNAME$ is $HOSTSTATE$ **" $CONTACTEMAIL$',
    },
    'notify-service-by-email' => {
      'command_line' => '/usr/bin/printf "%b" "***** Nagios *****\n\nNotification Type: $NOTIFICATIONTYPE$\n\nService: $SERVICEDESC$\nHost: $HOSTALIAS$\nAddress: $HOSTADDRESS$\nState: $SERVICESTATE$\n\nDate/Time: $LONGDATETIME$\n\nAdditional Info:\n\n$SERVICEOUTPUT$\n" | /usr/bin/mail -s "** $NOTIFICATIONTYPE$ Service Alert: $HOSTALIAS$/$SERVICEDESC$ is $SERVICESTATE$ **" $CONTACTEMAIL$',
    },
    'check-host-alive' => {
      'command_line' => '$USER1$/check_ping -H $HOSTADDRESS$ -w 3000.0,80% -c 5000.0,100% -p 5',
    },
    'check_local_disk' => {
      'command_line' => '$USER1$/check_disk -w $ARG1$ -c $ARG2$ -p $ARG3$',
    },
    'check_local_load' => {
      'command_line' => '$USER1$/check_load -w $ARG1$ -c $ARG2$',
    },
    'check_local_procs' => {
      'command_line' => '$USER1$/check_procs -w $ARG1$ -c $ARG2$ -s $ARG3$',
    },
    'check_local_users' => {
      'command_line' => '$USER1$/check_users -w $ARG1$ -c $ARG2$',
    },
    'check_local_swap' => {
      'command_line' => '$USER1$/check_swap -w $ARG1$ -c $ARG2$',
    },
    'check_local_mrtgtraf' => {
      'command_line' => '$USER1$/check_mrtgtraf -F $ARG1$ -a $ARG2$ -w $ARG3$ -c $ARG4$ -e $ARG5$',
    },
    'check_ftp' => {
      'command_line' => '$USER1$/check_ftp -H $HOSTADDRESS$ $ARG1$',
    },
    'check_hpjd' => {
      'command_line' => '$USER1$/check_hpjd -H $HOSTADDRESS$ $ARG1$',
    },
    'check_snmp' => {
      'command_line' => '$USER1$/check_snmp -H $HOSTADDRESS$ $ARG1$',
    },
    'check_http' => {
      'command_line' => '$USER1$/check_http -I $HOSTADDRESS$ $ARG1$',
    },
    'check_ssh' => {
      'command_line' => '$USER1$/check_ssh $ARG1$ $HOSTADDRESS$',
    },
    'check_dhcp' => {
      'command_line' => '$USER1$/check_dhcp $ARG1$',
    },
    'check_ping' => {
      'command_line' => '$USER1$/check_ping -H $HOSTADDRESS$ -w $ARG1$ -c $ARG2$ -p 5',
    },
    'check_pop' => {
      'command_line' => '$USER1$/check_pop -H $HOSTADDRESS$ $ARG1$',
    },
    'check_imap' => {
      'command_line' => '$USER1$/check_imap -H $HOSTADDRESS$ $ARG1$',
    },
    'check_smtp' => {
      'command_line' => '$USER1$/check_smtp -H $HOSTADDRESS$ $ARG1$',
    },
    'check_tcp' => {
      'command_line' => '$USER1$/check_tcp -H $HOSTADDRESS$ -p $ARG1$ $ARG2$',
    },
    'check_udp' => {
      'command_line' => '$USER1$/check_udp -H $HOSTADDRESS$ -p $ARG1$ $ARG2$',
    },
    'check_nt' => {
      'command_line' => '$USER1$/check_nt -H $HOSTADDRESS$ -p 12489 -v $ARG1$ $ARG2$',
    },
    'process-host-perfdata' => {
      'command_line' => '/usr/bin/printf "%b" "$LASTHOSTCHECK$\t$HOSTNAME$\t$HOSTSTATE$\t$HOSTATTEMPT$\t$HOSTSTATETYPE$\t$HOSTEXECUTIONTIME$\t$HOSTOUTPUT$\t$HOSTPERFDATA$\n" >> @localstatedir@/host-perfdata.out',
    },
    'process-service-perfdata' => {
      'command_line' => '/usr/bin/printf "%b" "$LASTSERVICECHECK$\t$HOSTNAME$\t$SERVICEDESC$\t$SERVICESTATE$\t$SERVICEATTEMPT$\t$SERVICESTATETYPE$\t$SERVICEEXECUTIONTIME$\t$SERVICELATENCY$\t$SERVICEOUTPUT$\t$SERVICEPERFDATA$\n" >> @localstatedir@/service-perfdata.out',
    },
    'check_nrpe'     => {
      'command_line' => '$USER1$/check_nrpe -H $HOSTADDRESS$ -t 60 -c $ARG1$',
    },
  }

}
