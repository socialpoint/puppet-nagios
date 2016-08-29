define nagios::resource_hash::hostdependency (
  $config = {},
){

  $resource_hash = { $name => $config }

  nagios::resource { $name:
    type          => 'nagios_hostdependency',
    resource_hash => $resource_hash,
  }

}
