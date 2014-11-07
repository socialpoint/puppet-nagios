# Low level defined resource from hash
# TODO: Document
define nagios::resource (
  $type,
  $resource_hash,
) {

  $resource_name = delete($type, 'nagios_')
  $target_name = uriescape(strip($name))
  $target = "${::nagios::params::nagios_resource_dir}/${resource_name}/${target_name}.cfg"

  # XXX: when an exported resource has an undef value, it gets realised as
  # undef string. We need to delete those entries before realising them
  $real_resource_hash = delete_undef_values($resource_hash[$name])

  # XXX: the string with a variable inside is needed otherwise puppet fails
  create_resources($type, { "${name}" =>  $real_resource_hash }, {
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
