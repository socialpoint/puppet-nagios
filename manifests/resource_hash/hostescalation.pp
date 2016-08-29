define nagios::resource_hash::hostescalation (
  $config = {},
){

  $resource_hash = { $name => $config }

  nagios::resource { $name:
    type          => 'nagios_hostescalation',
    resource_hash => $resource_hash,
  }

}
