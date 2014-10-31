define nagios::resource_hash::hostextinfo {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource { $names:
    type          => 'nagios_hostextinfo',
    resource_hash => $name,
  }

}
