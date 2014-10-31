define nagios::resource_hash::hostextinfo {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource_hash { $names:
    type          => 'nagios_hostextinfo',
    resource_hash => $name,
  }

}
