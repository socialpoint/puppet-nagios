define nagios::resource_hash::serviceescalation {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource { $names:
    type          => 'nagios_serviceescalation',
    resource_hash => $name,
  }

}
