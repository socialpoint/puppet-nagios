define nagios::resource_hash::hostescalation {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource_hash { $names:
    type          => 'nagios_hostescalation',
    resource_hash => $name,
  }

}
