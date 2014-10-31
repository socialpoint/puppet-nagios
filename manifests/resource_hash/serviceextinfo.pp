define nagios::resource_hash::serviceextinfo {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource { $names:
    type          => 'nagios_serviceextinfo',
    resource_hash => $name,
  }

}
