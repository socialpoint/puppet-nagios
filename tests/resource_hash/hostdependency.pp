$hash = {
  'dependency'                      => {
    'host_name'                     => 'WWW1',
    'dependent_host_name'           => 'DBASE1',
    'notification_failure_criteria' => 'd,u',
  }
}
nagios::resource_hash::hostdependency { $hash: }
