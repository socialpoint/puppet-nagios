define nagios::resource::service (
  $ensure = 'present',
  $check_command = undef,
  $exported = false,
  $nrpe = false,
  $sudo = false,
  $manage_sudo = true,
  $check_script_content = undef,
  $nrpe_user = $::nagios::params::nrpe_user,
  $nrpe_config_dir = $::nagios::params::nrpe_config_dir,
  $nrpe_service = $::nagios::params::nrpe_service,
  $nrpe_package = $::nagios::params::nrpe_package,
  $plugins_dir = $::nagios::params::plugins_dir,
  $host_name = undef,
  $use = undef,
  $action_url = undef,
  $active_checks_enabled = undef,
  $business_impact = undef,
  $check_freshness = undef,
  $check_interval = undef,
  $check_period = undef,
  $contact_groups = undef,
  $contacts = undef,
  $display_name = undef,
  $event_handler = undef,
  $event_handler_enabled = undef,
  $failure_prediction_enabled = undef,
  $first_notification_delay = undef,
  $flap_detection_enabled = undef,
  $flap_detection_options = undef,
  $freshness_threshold = undef,
  $group = undef,
  $high_flap_threshold = undef,
  $hostgroup_name = undef,
  $icon_image = undef,
  $icon_image_alt = undef,
  $initial_state = undef,
  $is_volatile = undef,
  $low_flap_threshold = undef,
  $max_check_attempts = undef,
  $normal_check_interval = undef,
  $notes = undef,
  $notes_url = undef,
  $notification_interval = undef,
  $notification_options = undef,
  $notification_period = undef,
  $notifications_enabled = undef,
  $obsess_over_service = undef,
  $owner = undef,
  $parallelize_check = undef,
  $passive_checks_enabled = undef,
  $poller_tag = undef,
  $process_perf_data = undef,
  $register = undef,
  $retain_nonstatus_information = undef,
  $retain_status_information = undef,
  $retry_check_interval = undef,
  $retry_interval = undef,
  $service_description = undef,
  $servicegroups = undef,
  $stalking_options = undef,
) {

  $check_command_name = split($check_command, '[\!\ ]')

  $real_check_command = $nrpe ? {
    true    => "check_nrpe!${name}",
    default => $check_command,
  }

  # XXX: when an exported resource has an undef value, it gets realised as
  # undef string. We need to delete those entries before realising them
  $resource_values = delete_undef_values({
    'ensure'                       => $ensure,
    'action_url'                   => $action_url,
    'active_checks_enabled'        => $active_checks_enabled,
    'business_impact'              => $business_impact,
    'check_command'                => $real_check_command,
    'check_freshness'              => $check_freshness,
    'check_interval'               => $check_interval,
    'check_period'                 => $check_period,
    'contact_groups'               => $contact_groups,
    'contacts'                     => $contacts,
    'display_name'                 => $display_name,
    'event_handler'                => $event_handler,
    'event_handler_enabled'        => $event_handler_enabled,
    'failure_prediction_enabled'   => $failure_prediction_enabled,
    'first_notification_delay'     => $first_notification_delay,
    'flap_detection_enabled'       => $flap_detection_enabled,
    'flap_detection_options'       => $flap_detection_options,
    'freshness_threshold'          => $freshness_threshold,
    'group'                        => $group,
    'high_flap_threshold'          => $high_flap_threshold,
    'host_name'                    => $host_name,
    'hostgroup_name'               => $hostgroup_name,
    'icon_image'                   => $icon_image,
    'icon_image_alt'               => $icon_image_alt,
    'initial_state'                => $initial_state,
    'is_volatile'                  => $is_volatile,
    'low_flap_threshold'           => $low_flap_threshold,
    'max_check_attempts'           => $max_check_attempts,
    'normal_check_interval'        => $normal_check_interval,
    'notes'                        => $notes,
    'notes_url'                    => $notes_url,
    'notification_interval'        => $notification_interval,
    'notification_options'         => $notification_options,
    'notification_period'          => $notification_period,
    'notifications_enabled'        => $notifications_enabled,
    'obsess_over_service'          => $obsess_over_service,
    'owner'                        => $owner,
    'parallelize_check'            => $parallelize_check,
    'passive_checks_enabled'       => $passive_checks_enabled,
    'poller_tag'                   => $poller_tag,
    'process_perf_data'            => $process_perf_data,
    'register'                     => $register,
    'retain_nonstatus_information' => $retain_nonstatus_information,
    'retain_status_information'    => $retain_status_information,
    'retry_check_interval'         => $retry_check_interval,
    'retry_interval'               => $retry_interval,
    'service_description'          => $service_description,
    'servicegroups'                => $servicegroups,
    'stalking_options'             => $stalking_options,
    'use'                          => $use,
  })
  $resource_hash = { "${name}" => $resource_values }

  if $exported {
    @@nagios::resource { "service-${name}":
      type          => 'nagios_service',
      resource_hash => $resource_hash,
    }
  } else {
    nagios::resource { "service-${name}":
      type          => 'nagios_service',
      resource_hash => $resource_hash,
    }
  }

  if $check_script_content {
    file { "${plugins_dir}/${check_command_name[0]}":
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      content => $check_script_content,
      require => Package[$nrpe_package],
    }
  }

  if $nrpe {
    if $sudo {
      $sudo_command = '/usr/bin/sudo '
      if $manage_sudo {
        sudo::conf { "nrpe-${name}":
          content  => "${nrpe_user} ALL=(ALL:ALL) NOPASSWD:${plugins_dir}/${check_command_name[0]}",
          priority => '50',
        }
      }
    } else {
      $sudo_command = ''
        sudo::conf { "nrpe-${name}":
          ensure => absent,
        }
    }

    file { "${nrpe_config_dir}/${name}.cfg":
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => "command[${name}]=${sudo_command}${plugins_dir}/${check_command}\n",
      require => Package[$nrpe_package],
      notify  => Service[$nrpe_service],
    }
  }

}
