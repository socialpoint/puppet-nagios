define nagios::resource::servicedependency {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource { $names:
    type          => 'nagios_servicedependency',
    resource_hash => $name,
  }

}
