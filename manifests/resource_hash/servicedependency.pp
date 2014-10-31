define nagios::resource_hash::servicedependency {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource { $names:
    type          => 'nagios_servicedependency',
    resource_hash => $name,
  }

}
