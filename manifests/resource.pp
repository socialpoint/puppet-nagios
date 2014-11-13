# Low level defined resource from hash
# TODO: Document
define nagios::resource (
  $type,
  $resource_hash,
) {

  $resourcetype_name = delete($type, 'nagios_')
  $resource_name = split($name, '-')
  $target_name = uriescape(strip($name))
  $target = "${::nagios::params::nagios_resource_dir}/${resourcetype_name}/${target_name}.cfg"

  # XXX: the string with a variable inside is needed otherwise puppet fails
  create_resources($type, { "${resource_name[1]}" =>  $resource_hash[$resource_name[1]] }, {
    'target'  => $target,
    'require' => "File[${target}]",
    'notify'  => "Service[${::nagios::params::nagios_service}]",
  } )

  # One file may have multiple resorces, so we first check if the resource has
  # been defined
  if !defined(File[$target]) {
    file { $target:
      ensure  => present,
      mode    => '0644',
      owner   => 'nagios',
      group   => 'nagios',
      require => Package[$::nagios::params::nagios_package_name],
      notify  => Service[$::nagios::params::nagios_service],
    }
  }

}
