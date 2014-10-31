define nagios::resource_hash::timeperiod {

  $names = split(inline_template('<%= @name.keys.join(\',\') %>'), ',')

  nagios::resource_hash { $names:
    type          => 'nagios_timeperiod',
    resource_hash => $name,
  }

}
