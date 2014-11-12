$hash = {
  'admins' => {
    'alias'   => 'Nagios Administrators',
    'members' => 'nagios',
  }
}
nagios::resource { 'admins':
  type          => 'nagios_contactgroup',
  resource_hash => $hash,
}
