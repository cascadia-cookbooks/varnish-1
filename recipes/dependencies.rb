#
# Cookbook Name:: cop_varnish
# Recipe:: dependencies
# Author:: Copious Inc. <engineering@copiousinc.com>
#

include_recipe 'cop_base::dependencies'

package node['varnish']['dependencies'] do
    action :install
end


case node['platform_family']
when 'debian'

    # NOTE: support for https in apt repos
    package 'apt-transport-https' do
        action :install
    end

    apt_repository 'varnish' do
        uri          "https://packagecloud.io/varnishcache/varnish#{node['varnish']['version']}/#{node['platform']}"
        distribution "#{node['lsb']['codename']}"
        key          "https://packagecloud.io/varnishcache/varnish#{node['varnish']['version']}/gpgkey"
        components   ['main']
    end

    execute 'update apt' do
        command 'apt-get update'
        action  :nothing
    end

when 'rhel'

    yum_repository 'varnish' do
        description "Varnish Repository - Packagecloud"
        baseurl "https://packagecloud.io/varnishcache/varnish#{node['varnish']['version']}/el/#{node['platform_version'].to_i}/$basearch/"
        enabled true
        gpgcheck false
        gpgkey "https://packagecloud.io/varnishcache/varnish#{node['varnish']['version']}/gpgkey"
        action :create
    end

end
