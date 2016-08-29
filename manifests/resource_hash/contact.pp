define nagios::resource_hash::contact (
  $config = {},
){

  $resource_hash = { $name => $config }

  nagios::resource { $name:
    type          => 'nagios_contact',
    resource_hash => $resource_hash,
  }

}
