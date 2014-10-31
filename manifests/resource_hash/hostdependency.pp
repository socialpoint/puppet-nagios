define nagios::resource_hash::hostdependency {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource_hash { $names:
    type          => 'nagios_hostdependency',
    resource_hash => $name,
  }

}
