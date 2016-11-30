#
# Cookbook Name:: cop_varnish
# Recipe:: dependencies
# Author:: Copious Inc. <engineering@copiousinc.com>
#

cache = Chef::Config[:file_cache_path]

case node['platform_family']
when 'debian'
    include_recipe 'apt::default'
when 'rhel'
    version  = node['platform_version'].to_i

    remote_file 'download epel' do
        path   "#{cache}/epel"
        source "http://fedora-epel.mirrors.tds.net/fedora-epel/epel-release-latest-#{version}.noarch.rpm"
        owner  'root'
        group  'root'
        mode   0644
        action :create
    end

    package "#{cache}/epel" do
        action   :install
        provider Chef::Provider::Package::Rpm
    end
when 'fedora'
    # NOTE: workaround for lack of Chef DNF provider on fedora >= 19
    execute 'dnf install -y yum' do
        command 'dnf install -y yum'
        only_if 'test -f /usr/bin/dnf'
        creates '/usr/bin/yum-deprecated'
    end
end

node['varnish']['dependencies'].each do |p|
    package p do
        action :install
    end
end
