# Low level defined resource
# TODO: Document
define nagios::resource (
  $type,
  $resource_hash,
) {

  $resource_name = delete($type, 'nagios_')
  $target_name = uriescape(strip($name))
  $target = "${::nagios::params::nagios_resource_dir}/${resource_name}/${target_name}.cfg"

  # XXX: the string with a variable inside is needed otherwise puppet fails
  create_resources($type, { "${name}" =>  $resource_hash[$name] }, { 'target' => $target } )

  if !defined(File[$target]) {
    file { $target:
      ensure => present,
      mode   => '0644',
      owner  => 'nagios',
      group  => 'nagios',
    }
  }

}
