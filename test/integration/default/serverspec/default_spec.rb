require 'spec_helper'

describe 'cop_varnish::default' do
  describe package('varnish') do
    it { should be_installed }
  end

  describe command('varnishd -V') do
    its(:stderr) { should include "5" }
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

  # varnish default
  describe port(80) do
    it { should be_listening.with('tcp') }
  end

  # varnish admin
  describe port(6082) do
    it { should be_listening.with('tcp') }
  end
end

describe 'cop_varnish::vcl' do
  describe file('/etc/varnish/default.vcl') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '644' }
    its(:content) { should include 'if (req.url ~ "/test1/regex.url")' }
    its(:content) { should include 'if (req.url ~ "/test2/regex.url")' }
  end
end
