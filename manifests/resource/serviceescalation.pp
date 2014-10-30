define nagios::resource::serviceescalation {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource { $names:
    type          => 'nagios_serviceescalation',
    resource_hash => $name,
  }

}
