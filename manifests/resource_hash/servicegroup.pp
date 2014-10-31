define nagios::resource_hash::servicegroup {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource_hash { $names:
    type          => 'nagios_servicegroup',
    resource_hash => $name,
  }

}
