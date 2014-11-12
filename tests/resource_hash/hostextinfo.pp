$hash = {
  'hostextinfo'       => {
    'host_name'       => 'netware1',
    'notes'           => 'This is the primary Netware file server',
    'notes_url'       => 'http://webserver.localhost.localdomain/hostinfo.pl?host=netware1',
    'icon_image'      => 'novell40.png',
    'icon_image_alt'  => 'IntranetWare 4.11',
    'vrml_image'      => 'novell40.png',
    'statusmap_image' => 'novell40.gd2',
    '2d_coords'       => '100,250',
    '3d_coords'       => '100.0,50.0,75.0',
  }
}
nagios::resource_hash::hostextinfo { $hash: }
