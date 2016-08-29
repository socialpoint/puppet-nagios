define nagios::resource_hash::contactgroup (
  $config = {},
){

  $resource_hash = { $name => $config }

  nagios::resource { $name:
    type          => 'nagios_contactgroup',
    resource_hash => $resource_hash,
  }

}
