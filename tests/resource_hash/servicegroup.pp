$hash = {
  'dbservices' => {
    'alias'    => 'Database Services',
    'members'  => 'ms1,SQL Server,ms1,SQL Server Agent,ms1,SQL DTC',
  }
}
nagios::resource_hash::servicegroup { $hash: }
