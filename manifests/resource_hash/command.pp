define nagios::resource_hash::command {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource_hash { $names:
    type          => 'nagios_command',
    resource_hash => $name,
  }

}
