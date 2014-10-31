define nagios::resource_hash::service {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource_hash { $names:
    type          => 'nagios_service',
    resource_hash => $name,
  }

}
