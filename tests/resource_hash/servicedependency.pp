$hash = {
  'servicedependency1'            => {
    'host_name'                     => 'WWW1',
    'service_description'           => 'Apache Web Server',
    'dependent_host_name'           => 'WWW1',
    'dependent_service_description' => 'Main Web Site',
    'execution_failure_criteria'    => 'n',
    'notification_failure_criteria' => 'w,u,c',
  }
}
nagios::resource_hash::servicedependency { $hash: }
