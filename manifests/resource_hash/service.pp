define nagios::resource_hash::service (
  $config = {},
){

  $resource_hash = { $name => $config }

  nagios::resource { $name:
    type          => 'nagios_service',
    resource_hash => $resource_hash,
  }

}
