define nagios::resource_hash::hostgroup (
  $config = {},
){

  $resource_hash = { $name => $config }

  nagios::resource { $name:
    type          => 'nagios_hostgroup',
    resource_hash => $resource_hash,
  }

}
