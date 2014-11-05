define nagios::resource::timeperiod (
  $ensure = 'present',
  $alias = undef,
  $exclude = undef,
  $group = undef,
  $mode = undef,
  $owner = undef,
  $provider = undef,
  $register = undef,
  $use = undef,
  $monday = undef,
  $tuesday = undef,
  $wednesday = undef,
  $thursday = undef,
  $friday = undef,
  $saturday = undef,
  $sunday = undef,
) {

  $resource_hash = {
    "${name}"     => {
      'ensure'    => $ensure,
      'alias'     => $alias,
      'exclude'   => $exclude,
      'group'     => $group,
      'mode'      => $mode,
      'owner'     => $owner,
      'provider'  => $provider,
      'register'  => $register,
      'use'       => $use,
      'monday'    => $monday,
      'tuesday'   => $tuesday,
      'wednesday' => $wednesday,
      'thursday'  => $thursday,
      'friday'    => $friday,
      'saturday'  => $saturday,
      'sunday'    => $sunday,
    }
  }

  nagios::resource { $name:
    type          => 'nagios_timeperiod',
    resource_hash => $resource_hash,
  }

}
