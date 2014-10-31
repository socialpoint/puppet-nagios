define nagios::resource_hash::host {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource { $names:
    type          => 'nagios_host',
    resource_hash => $name,
  }

}
