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

templates = {
    '/etc/varnish/varnish.params' => 'varnish.params.erb',
    '/etc/varnish/default.vcl'    => 'default.vcl.erb',
}

templates.each do |f,t|
    template f do
        cookbook 'cop_varnish'
        source   t
        group    'root'
        owner    'root'
        mode     0644
        backup   5
        action   :create
        notifies :restart, 'service[varnish]', :delayed
    end
end

template '/etc/init.d/varnish' do
    cookbook 'cop_varnish'
    source   'varnish.init.erb'
    group    'root'
    owner    'root'
    mode     0755
    backup   5
    action   :create
    not_if   'ps -p 1 -o comm= | grep systemd'
    notifies :restart, 'service[varnish]', :delayed
end

directory '/usr/lib/systemd/system/' do
    owner  'root'
    group  'root'
    mode   0755
    action :create 
end

template '/usr/lib/systemd/system/varnish.service' do
    cookbook 'cop_varnish'
    source   'varnish.service.erb'
    group    'root'
    owner    'root'
    mode     0644
    backup   5
    action   :create
    only_if  'ps -p 1 -o comm= | grep systemd'
    notifies :run, 'execute[reload systemctl]', :immediately
    notifies :restart, 'service[varnish]', :delayed
end

execute 'reload systemctl' do
    command 'systemctl daemon-reload'
    action  :nothing
end

cookbook_file '/etc/logrotate.d/varnish' do
    cookbook 'cop_varnish'
    source   'logrotate'
    owner    'root'
    group    'root'
    mode     0755
    action   :create
end

service 'varnish' do
    action [:enable, :start]
end
