define nagios::resource::hostgroup (
  $ensure = 'present',

  $action_url = undef,
  $hostgroup_alias = undef,
  $hostgroup_members = undef,
  $members = undef,
  $notes = undef,
  $notes_url = undef,
  $realm = undef,
  $register = undef,
  $use = undef,
) {

  $resource_hash = {
    "${name}"             => {
      'ensure'            => $ensure,
      'action_url'        => $action_url,
      'alias'             => $hostgroup_alias,
      'hostgroup_members' => $hostgroup_members,
      'members'           => $members,
      'notes'             => $notes,
      'notes_url'         => $notes_url,
      'realm'             => $realm,
      'register'          => $register,
      'use'               => $use,
    }
  }

  nagios::resource { "hostgroup-${name}":
    type          => 'nagios_hostgroup',
    resource_hash => $resource_hash,
  }

}
