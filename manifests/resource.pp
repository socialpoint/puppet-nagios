# Low level defined resource
# TODO: Document
define nagios::resource (
  $type,
  $resource_hash,
) {

  create_resources($type, { "${name}" => $resource_hash[$name] } )

  if !defined(File[$resource_hash[$name]['target']]) {
    file { $resource_hash[$name]['target']:
      ensure => present,
      mode   => '0644',
      owner  => 'nagios',
      group  => 'nagios',
    }
  }

}
