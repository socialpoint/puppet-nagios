define nagios::resource::service {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource { $names:
    type          => 'nagios_service',
    resource_hash => $name,
  }

}
