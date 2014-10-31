define nagios::resource_hash::contact {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource_hash { $names:
    type          => 'nagios_contact',
    resource_hash => $name,
  }

}
