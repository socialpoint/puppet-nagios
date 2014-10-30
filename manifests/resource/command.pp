define nagios::resource::command {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource { $names:
    type          => 'nagios_command',
    resource_hash => $name,
  }

}
