nagios::resource::timeperiod { 'workhours':
  alias     => 'Non-Work Hours',
  monday    => '00:00-09:00,17:00-24:00',
  tuesday   => '00:00-09:00,17:00-24:00',
  wednesday => '00:00-09:00,17:00-24:00',
  thursday  => '00:00-09:00,17:00-24:00',
  friday    => '00:00-09:00,17:00-24:00',
  saturday  => '00:00-24:00',
  sunday    => '00:00-24:00',
}
