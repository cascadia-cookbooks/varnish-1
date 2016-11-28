require 'spec_helper'

describe 'cop_varnish::default' do
  describe package('varnish') do
    it { should be_installed }
  end

  describe command('varnishd -V') do
    its(:stderr) { should match /4.?.*/ }
  end

  describe file('/etc/varnish/default.vcl') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '644' }
  end
end
