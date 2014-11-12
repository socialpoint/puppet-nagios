$hash = {
  'hostescalation'          => {
    'host_name'             => 'router-34',
    'first_notification'    => '5',
    'last_notification'     => '8',
    'notification_interval' => '60',
    'contact_groups'        => 'all-router-admins',
  }
}
nagios::resource_hash::hostescalation { $hash: }
