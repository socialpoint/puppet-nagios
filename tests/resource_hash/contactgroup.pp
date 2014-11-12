$hash = {
  'novell-admins' => {
    'alias'   => 'Novell Administrators',
    'members' => 'jdoe,rtobert,tzach',
  }
}
nagios::resource_hash::contactgroup { $hash: }
