define nagios::resource_hash::hostgroup {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource { $names:
    type          => 'nagios_hostgroup',
    resource_hash => $name,
  }

}
