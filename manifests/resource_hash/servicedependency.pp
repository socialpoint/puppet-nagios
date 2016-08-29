define nagios::resource_hash::servicedependency (
  $config = {},
){

  $resource_hash = { $name => $config }

  nagios::resource { $name:
    type          => 'nagios_servicedependency',
    resource_hash => $resource_hash,
  }

}
