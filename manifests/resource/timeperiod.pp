define nagios::resource::timeperiod (
  $ensure = 'present',
  $timeperiod_alias = undef,
  $exclude = undef,
  $group = undef,
  $owner = undef,
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
      'alias'     => $timeperiod_alias,
      'exclude'   => $exclude,
      'group'     => $group,
      'owner'     => $owner,
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

  nagios::resource { "timeperiod-${name}":
    type          => 'nagios_timeperiod',
    resource_hash => $resource_hash,
  }

}
