define nagios::resource_hash::servicegroup {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource { $names:
    type          => 'nagios_servicegroup',
    resource_hash => $name,
  }

}
