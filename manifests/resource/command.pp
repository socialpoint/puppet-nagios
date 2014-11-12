define nagios::resource::command (
  $ensure = 'present',
  $command_line = undef,
  $poller_tag = undef,
  $target = undef,
  $use = undef,
) {

  $resource_hash = {
    "${name}"        => {
      'ensure'       => $ensure,
      'command_line' => $command_line,
      'poller_tag'   => $poller_tag,
      'use'          => $use,
    }
  }

  nagios::resource { $name:
    type          => 'nagios_command',
    resource_hash => $resource_hash,
  }

}
