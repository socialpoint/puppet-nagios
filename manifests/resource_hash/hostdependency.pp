define nagios::resource_hash::hostdependency {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource { $names:
    type          => 'nagios_hostdependency',
    resource_hash => $name,
  }

}
