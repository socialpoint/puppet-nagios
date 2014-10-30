define nagios::resource::contact {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource { $names:
    type          => 'nagios_contact',
    resource_hash => $name,
  }

}
