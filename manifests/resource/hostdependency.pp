define nagios::resource::hostdependency {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource { $names:
    type          => 'nagios_hostdependency',
    resource_hash => $name,
  }

}
