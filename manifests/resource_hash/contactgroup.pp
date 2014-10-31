define nagios::resource_hash::contactgroup {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource_hash { $names:
    type          => 'nagios_contactgroup',
    resource_hash => $name,
  }

}
