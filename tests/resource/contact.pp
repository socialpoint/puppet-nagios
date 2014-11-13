include nagios::params
nagios::resource::contact { 'jdoe':
  alias                         => 'John Doe',
  host_notifications_enabled    => '1',
  service_notifications_enabled => '1',
  service_notification_period   => '24x7',
  host_notification_period      => '24x7',
  service_notification_options  => 'w,u,c,r',
  host_notification_options     => 'd,u,r',
  service_notification_commands => 'notify-by-email',
  host_notification_commands    => 'host-notify-by-email',
  email                         => 'jdoe@localhost.localdomain',
  pager                         => '555-5555@pagergateway.localhost.localdomain',
  address1                      => 'xxxxx.xyyy@icq.com',
  address2                      => '555-555-5555',
  can_submit_commands           => '1',
}
