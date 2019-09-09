# InSpec test for recipe coturn::default

# The InSpec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/


# try this on a real machine?
describe service('coturn'), :skip do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe package 'coturn' do
  it { should be_installed }
end

[3478, 5349].each do |port_num|
  describe port port_num do
    its('processes') { should include 'turnserver' }
    its('protocols') { should include 'tcp' }
    its('protocols') { should include 'udp' }
  end
end

describe file('/etc/default/coturn') do
  its('content') { should match 'TURNSERVER_ENABLED=1' }
end