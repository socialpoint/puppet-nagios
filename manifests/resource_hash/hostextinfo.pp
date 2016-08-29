define nagios::resource_hash::hostextinfo (
  $config = {},
){

  $resource_hash = { $name => $config }

  nagios::resource { $name:
    type          => 'nagios_hostextinfo',
    resource_hash => $resource_hash,
  }

}
