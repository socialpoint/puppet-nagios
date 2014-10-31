define nagios::resource_hash::servicedependency {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource_hash { $names:
    type          => 'nagios_servicedependency',
    resource_hash => $name,
  }

}
