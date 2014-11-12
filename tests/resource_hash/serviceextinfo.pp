$hash = {
  'serviceextinfo'        => {
    'host_name'           => 'linux2',
    'service_description' => 'Log Anomalies',
    'notes'               => 'Security-related log anomalies on secondary Linux server',
    'notes_url'           => 'http://webserver.localhost.localdomain/serviceinfo.pl?host=linux2&service=Log+Anomalies',
    'icon_image'          => 'security.png',
    'icon_image_alt'      => 'Security-Related Alerts',
  }
}
nagios::resource_hash::serviceextinfo { $hash: }
