define puppet-nagios::resource::servicegroup (
  $ensure = 'present',
  $action_url = undef,
  $alias = undef,
  $members = undef,
  $notes = undef,
  $notes_url = undef,
  $register = undef,
  $servicegroup_members = undef,
  $use = undef,
) {

  $resource_hash = {
    "${name}"                => {
      'ensure'               => $ensure,
      'action_url'           => $action_url,
      'alias'                => $alias,
      'members'              => $members,
      'notes'                => $notes,
      'notes_url'            => $notes_url,
      'register'             => $register,
      'servicegroup_members' => $servicegroup_members,
      'use'                  => $use,

    }
  }

  nagios::resource { $name:
    type          => 'nagios_servicegroup',
    resource_hash => $resource_hash,
  }

}
