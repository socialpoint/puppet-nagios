include nagios::params
nagios::resource::contactgroup { 'admins':
  alias   => 'Nagios Administrators',
  members => 'nagios',
}
