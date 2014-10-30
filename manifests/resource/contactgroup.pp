define nagios::resource::contactgroup {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource { $names:
    type          => 'nagios_contactgroup',
    resource_hash => $name,
  }

}
