#
# Cookbook Name:: cop_varnish
# Recipe:: dependencies
# Author:: Copious Inc. <engineering@copiousinc.com>
#

cache = Chef::Config[:file_cache_path]

case node['platform_family']
when 'debian'
    include_recipe 'apt::default'
when 'rhel', 'fedora'
    version  = node['platform_version'].to_i

    case version
    when 7, 19..23
        epel = "epel-release-latest-7.noarch.rpm"
    when 6, 12..13
        epel = "epel-release-latest-6.noarch.rpm"
    when 5
        epel = "epel-release-latest-5.noarch.rpm"
    end

    remote_file 'download epel' do
        path   "#{cache}/epel"
        source "http://fedora-epel.mirrors.tds.net/fedora-epel/#{epel}"
        owner  'root'
        group  'root'
        mode   0644
        action :create
    end

    package "#{cache}/epel" do
        action   :install
        provider Chef::Provider::Package::Rpm
    end
end

# NOTE: workaround for lack of Chef DNF provider on fedora >= 19
execute 'dnf install -y yum' do
    command 'dnf install -y yum'
    only_if 'test -f /usr/bin/dnf'
    creates '/usr/bin/yum-deprecated'
end

node['varnish']['dependencies'].each do |p|
    package p do
        action :install
    end
end
