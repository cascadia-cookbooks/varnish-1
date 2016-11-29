require 'spec_helper'

describe 'cop_varnish::default' do
  describe file('/usr/local/sbin/varnishd') do
    it { should be_executable }
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '755' }
  end

  describe command('/usr/local/sbin/varnishd -V') do
    its(:stderr) { should match /4.1.3/ }
  end

  describe file('/etc/varnish/default.vcl') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '644' }
  end

  describe file('/etc/varnish/secret') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '600' }
  end

  describe file('/var/lib/varnish') do
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '755' }
  end

  describe service('varnish') do
    it { should be_running }
  end
end
