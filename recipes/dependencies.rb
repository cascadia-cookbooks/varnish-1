#
# Cookbook Name:: cop_varnish
# Recipe:: dependencies
# Author:: Copious Inc. <engineering@copiousinc.com>
#

case node['platform_family']
when 'debian'
    include_recipe 'apt::default'
when 'rhel'
    package 'epel-release' do
        action :install
    end
end

node['varnish']['dependencies'].each do |p|
    package p do
        action :install
    end
end
