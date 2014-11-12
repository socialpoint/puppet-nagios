require 'spec_helper'

describe 'nagios::plugins' do
  let(:facts) { {
    :operatingsystem => 'Ubuntu',
  } }
  it { should contain_package('nagios-plugins') }
  it { should contain_package('nagios-plugins-basic') }
  it { should contain_package('nagios-plugins-contrib') }
  it { should contain_package('nagios-nrpe-plugin') }
end
