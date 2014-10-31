define nagios::resource_hash::timeperiod {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource { $names:
    type          => 'nagios_timeperiod',
    resource_hash => $name,
  }

}
