define nagios::resource_hash::command (
  $config = {},
){

  $resource_hash = { $name => $config }

  nagios::resource { $name:
    type          => 'nagios_command',
    resource_hash => $resource_hash,
  }

}
