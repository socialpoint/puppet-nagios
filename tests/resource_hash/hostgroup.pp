$hash = {
  'novell-servers' => {
    'alias'        => 'Novell Servers',
    'members'      => 'netware1,netware2,netware3,netware4',
  }
}
nagios::resource_hash::hostgroup { $hash: }
