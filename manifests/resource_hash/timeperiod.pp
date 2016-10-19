define nagios::resource_hash::timeperiod (
  $config = {},
){

  $resource_hash = { $name => $config }

  nagios::resource { $name:
    type          => 'nagios_timeperiod',
    resource_hash => $resource_hash,
  }

}
