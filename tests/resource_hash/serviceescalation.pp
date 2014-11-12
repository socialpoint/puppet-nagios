$hash = {
  'serviceescalation'       => {
    'host_name'             => 'host1',
    'service_description'   => 'Processor Load',
    'first_notification'    => '4',
    'last_notification'     => '0',
    'notification_interval' => '30',
    'contact_groups'        => 'admins',
  }
}
nagios::resource_hash::serviceescalation { $hash: }
