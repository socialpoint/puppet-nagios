define nagios::resource::contactgroup (
  $ensure = 'present',
  $contacgroup_alias = undef,
  $contactgroup_members = undef,
  $group = undef,
  $members = undef,
  $owner = undef,
  $register = undef,
  $use = undef,
) {

  $resource_hash = {
    "${name}"                => {
      'ensure'               => $ensure,
      'alias'                => $contacgroup_alias,
      'contactgroup_members' => $contactgroup_members,
      'group'                => $group,
      'members'              => $members,
      'owner'                => $owner,
      'register'             => $register,
      'use'                  => $use,
    }
  }

  nagios::resource { $name:
    type          => 'nagios_contactgroup',
    resource_hash => $resource_hash,
  }

}
