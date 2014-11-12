$hash =  {
  'check_pop' => {
    'command_line' => '/usr/local/nagios/libexec/check_pop -H $HOSTADDRESS$',
  }
}
nagios::resource_hash::command { $hash: }
