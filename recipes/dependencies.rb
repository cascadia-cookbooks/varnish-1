#
# Cookbook Name:: cop_varnish
# Recipe:: dependencies
# Author:: Copious Inc. <engineering@copiousinc.com>
#

include_recipe 'cop_base::dependencies'

package node['varnish']['dependencies'] do
    action :install
end
