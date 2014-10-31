define nagios::resource_hash::host {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource_hash { $names:
    type          => 'nagios_host',
    resource_hash => $name,
  }

}
