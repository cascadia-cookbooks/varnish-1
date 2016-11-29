#
# Cookbook Name:: cop_varnish
# Recipe:: configure
# Author:: Copious Inc. <engineering@copiousinc.com>
#

require 'securerandom'

secret = node['varnish']['secret'] || SecureRandom.uuid

file '/etc/varnish/secret' do
    user    'root'
    group   'root'
    mode    0600
    content secret
    action  :create_if_missing
end

template '/etc/varnish/varnish.params' do
    source   'varnish.params.erb'
    group    'root'
    owner    'root'
    mode     0644
    backup   false
    action   :create
    notifies :restart, 'service[varnish]', :delayed
end

template '/etc/varnish/default.vcl' do
    source   'default.vcl.erb'
    group    'root'
    owner    'root'
    mode     0644
    backup   false
    action   :create
    notifies :restart, 'service[varnish]', :delayed
end

template '/etc/systemd/system/varnish.service' do
    source   'varnish.service.erb'
    group    'root'
    owner    'root'
    mode     0644
    backup   false
    action   :create
    notifies :restart, 'service[varnish]', :delayed
end

cookbook_file '/etc/logrotate.d/varnish' do
    source 'logrotate'
    owner  'root'
    group  'root'
    mode   0755
    action :create
end

service 'varnish' do
    action [:enable, :start]
end
