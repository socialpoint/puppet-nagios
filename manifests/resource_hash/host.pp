define nagios::resource_hash::host (
  $config = {},
){

  $resource_hash = { $name => $config }

  nagios::resource { $name:
    type          => 'nagios_host',
    resource_hash => $resource_hash,
  }

}
