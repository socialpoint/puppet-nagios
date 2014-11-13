define nagios::resource::contact (
  $ensure = 'present',
  $exported = false,
  $manage_htpasswd = $::nagios::params::manage_htpasswd,
  $htpasswd_file = $::nagios::params::htpasswd_file,
  $cryptpasswd =  undef,
  $address1 = undef,
  $address2 = undef,
  $address3 = undef,
  $address4 = undef,
  $address5 = undef,
  $address6 = undef,
  $contact_alias = undef,
  $can_submit_commands = undef,
  $contactgroups = undef,
  $email = undef,
  $group = undef,
  $host_notification_commands = undef,
  $host_notification_options = undef,
  $host_notification_period = undef,
  $host_notifications_enabled = undef,
  $owner = undef,
  $pager = undef,
  $register = undef,
  $retain_nonstatus_information = undef,
  $retain_status_information = undef,
  $service_notification_commands = undef,
  $service_notification_options = undef,
  $service_notification_period = undef,
  $service_notifications_enabled = undef,
  $use = undef,
) {

  # XXX: when an exported resource has an undef value, it gets realised as
  # undef string. We need to delete those entries before realising them
  $resource_values = delete_undef_values( {
    'ensure'                        => $ensure,
    'address1'                      => $address1,
    'address2'                      => $address2,
    'address3'                      => $address3,
    'address4'                      => $address4,
    'address5'                      => $address5,
    'address6'                      => $address6,
    'alias'                         => $contact_alias,
    'can_submit_commands'           => $can_submit_commands,
    'contactgroups'                 => $contactgroups,
    'email'                         => $email,
    'group'                         => $group,
    'host_notification_commands'    => $host_notification_commands,
    'host_notification_options'     => $host_notification_options,
    'host_notification_period'      => $host_notification_period,
    'host_notifications_enabled'    => $host_notifications_enabled,
    'owner'                         => $owner,
    'pager'                         => $pager,
    'register'                      => $register,
    'retain_nonstatus_information'  => $retain_nonstatus_information,
    'retain_status_information'     => $retain_status_information,
    'service_notification_commands' => $service_notification_commands,
    'service_notification_options'  => $service_notification_options,
    'service_notification_period'   => $service_notification_period,
    'service_notifications_enabled' => $service_notifications_enabled,
    'use'                           => $use,
  })
  $resource_hash = { "${name}" => $resource_values }

  if $exported {
    @@nagios::resource { "contact-${name}":
      type          => 'nagios_contact',
      resource_hash => $resource_hash,
    }
  } else {
    nagios::resource { "contact-${name}":
      type          => 'nagios_contact',
      resource_hash => $resource_hash,
    }
  }

  if $manage_htpasswd {
    htpasswd { $name:
      ensure      => $ensure,
      cryptpasswd => $cryptpasswd,
      target      => $htpasswd_file,
    }
  }

}
