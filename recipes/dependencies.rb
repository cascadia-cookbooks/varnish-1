#
# Cookbook Name:: cop_varnish
# Recipe:: dependencies
# Author:: Copious Inc. <engineering@copiousinc.com>
#

include_recipe 'cop_base::dependencies'

node['varnish']['dependencies'].each do |p|
    package p do
        action :install
    end
end
