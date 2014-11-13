define nagios::resource::command (
  $ensure = 'present',
  $command_line = undef,
  $poller_tag = undef,
  $target = undef,
  $use = undef,
) {

  $resource_hash = {
    "command-${name}" => {
      'ensure'        => $ensure,
      'command_line'  => $command_line,
      'poller_tag'    => $poller_tag,
      'use'           => $use,
    }
  }

  nagios::resource { "command-${name}":
    type          => 'nagios_command',
    resource_hash => $resource_hash,
  }

}
